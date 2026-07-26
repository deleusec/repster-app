-- ============================================================
-- Repster — Do not crash the export on an empty claims setting
-- ------------------------------------------------------------
-- The role guard added in 20260726201500 cast `request.jwt.claims` to jsonb.
-- `current_setting(..., true)` answers NULL when the setting is absent, which
-- casts fine — but an empty *string* raises `invalid input syntax for type
-- json`, turning the whole export into an error.
--
-- Found by probing the guard: the "no JWT at all" case (the manual GDPR
-- runbook) blew up instead of being allowed through. NULLIF folds the empty
-- string back onto the NULL path.
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
    NULLIF(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role',
    ''
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
