-- ============================================================
-- Repster — Tighten who may export someone else's data
-- ------------------------------------------------------------
-- `export_user_data` recognised the service role by `auth.uid()` being NULL.
-- That is true of the service role, but also of any token carrying
-- `role: authenticated` without a `sub` claim — which would have walked
-- straight past the ownership check with an arbitrary uid.
--
-- Forging such a token requires the JWT secret, so the hole was narrow, but
-- this is the function that hands over a full copy of someone's account: the
-- caller's role is now checked explicitly.
--
-- A connection with no JWT at all (the SQL editor, used by the manual GDPR
-- runbook) is still allowed through — that is the `''` branch.
-- ============================================================

CREATE OR REPLACE FUNCTION public.export_user_data(target_user UUID DEFAULT NULL)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, auth, pg_temp
AS $$
DECLARE
  uid UUID := COALESCE(target_user, auth.uid());
  caller UUID := auth.uid();
  jwt_role TEXT := COALESCE(
    current_setting('request.jwt.claims', true)::jsonb ->> 'role', ''
  );
BEGIN
  IF uid IS NULL THEN
    RAISE EXCEPTION 'export_user_data: no user to export';
  END IF;

  -- A signed-in caller is confined to their own data.
  IF caller IS NOT NULL AND uid <> caller THEN
    RAISE EXCEPTION 'export_user_data: cannot export another user''s data';
  END IF;

  -- No `sub` claim: only the service role, or a direct database connection
  -- carrying no JWT at all, may act on someone else's behalf.
  IF caller IS NULL AND jwt_role NOT IN ('', 'service_role') THEN
    RAISE EXCEPTION 'export_user_data: caller may not export this user';
  END IF;

  RETURN jsonb_build_object(
    'exported_at', now(),
    'user_id', uid,
    'account', (
      SELECT jsonb_build_object(
        'email', u.email,
        'created_at', u.created_at,
        'last_sign_in_at', u.last_sign_in_at,
        'email_confirmed_at', u.email_confirmed_at,
        'profile', u.raw_user_meta_data
      )
      FROM auth.users u
      WHERE u.id = uid
    ),
    'exercises', (
      SELECT COALESCE(jsonb_agg(to_jsonb(e) ORDER BY e.name), '[]'::jsonb)
      FROM exercises e
      WHERE e.user_id = uid
    ),
    'workout_templates', (
      SELECT COALESCE(
        jsonb_agg(
          to_jsonb(t) || jsonb_build_object(
            'exercises', (
              SELECT COALESCE(
                jsonb_agg(to_jsonb(te) ORDER BY te.position), '[]'::jsonb
              )
              FROM template_exercises te
              WHERE te.template_id = t.id
            )
          )
          ORDER BY t.position
        ),
        '[]'::jsonb
      )
      FROM workout_templates t
      WHERE t.user_id = uid
    ),
    'workout_sessions', (
      SELECT COALESCE(
        jsonb_agg(
          to_jsonb(s) || jsonb_build_object(
            'exercises', (
              SELECT COALESCE(
                jsonb_agg(
                  to_jsonb(se) || jsonb_build_object(
                    'sets', (
                      SELECT COALESCE(
                        jsonb_agg(to_jsonb(ss) ORDER BY ss.set_number),
                        '[]'::jsonb
                      )
                      FROM session_sets ss
                      WHERE ss.session_exercise_id = se.id
                    )
                  )
                  ORDER BY se.position
                ),
                '[]'::jsonb
              )
              FROM session_exercises se
              WHERE se.session_id = s.id
            )
          )
          ORDER BY s.started_at
        ),
        '[]'::jsonb
      )
      FROM workout_sessions s
      WHERE s.user_id = uid
    ),
    'support_requests', (
      SELECT COALESCE(
        jsonb_agg(to_jsonb(c) ORDER BY c.created_at), '[]'::jsonb
      )
      FROM contact_requests c
      WHERE c.user_id = uid
    ),
    'avatar_note',
      'If a profile picture is set, it is the storage object '
      || 'avatars/' || uid::text || '/avatar.jpg and must be attached '
      || 'separately.'
  );
END;
$$;

REVOKE ALL ON FUNCTION public.export_user_data(UUID) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.export_user_data(UUID) FROM anon;
GRANT EXECUTE ON FUNCTION public.export_user_data(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION public.export_user_data(UUID) TO service_role;
