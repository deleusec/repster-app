-- ============================================================
-- Repster — GDPR data export (right of access / portability)
-- ------------------------------------------------------------
-- The privacy policy (section 9) promises a copy of a user's data "in a
-- structured, readable format (JSON)", handled manually on request. Doing that
-- by hand across seven tables is how you end up shipping an incomplete export,
-- so it lives in one function instead.
--
-- Two callers:
--   • the service role, for a request that arrives by email — pass the uid;
--   • an authenticated user, for their own data — pass nothing.
-- `anon` cannot call it at all, which matters because the service-role branch
-- is recognised by `auth.uid()` being NULL.
--
-- SECURITY DEFINER is required to read `auth.users` and `contact_requests`,
-- neither of which is SELECT-able by `authenticated`.
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
BEGIN
  IF uid IS NULL THEN
    RAISE EXCEPTION 'export_user_data: no user to export';
  END IF;

  -- An authenticated caller is confined to their own data. A NULL caller is
  -- the service role (EXECUTE is not granted to anon).
  IF caller IS NOT NULL AND uid <> caller THEN
    RAISE EXCEPTION 'export_user_data: cannot export another user''s data';
  END IF;

  RETURN jsonb_build_object(
    'exported_at', now(),
    'user_id', uid,

    -- Explicit field list: `auth.users` also holds password hashes and
    -- recovery tokens, which must never reach an export.
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

    -- Certified catalogue rows are excluded: they are ours, not the user's.
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

    -- Support messages outlive the account (privacy policy, section 8), but
    -- as long as they are still linked they belong in the export.
    'support_requests', (
      SELECT COALESCE(
        jsonb_agg(to_jsonb(c) ORDER BY c.created_at), '[]'::jsonb
      )
      FROM contact_requests c
      WHERE c.user_id = uid
    ),

    -- The avatar is a storage object, not a row: point at it rather than
    -- inlining base64 into the JSON.
    'avatar_note',
      'If a profile picture is set, it is the storage object '
      || 'avatars/' || uid::text || '/avatar.jpg and must be attached '
      || 'separately.'
  );
END;
$$;

COMMENT ON FUNCTION public.export_user_data(UUID) IS
  'GDPR right of access / portability (privacy policy, section 9). Called '
  'with no argument by an authenticated user for their own data, or with a '
  'uid by the service role when a request arrives by email.';

REVOKE ALL ON FUNCTION public.export_user_data(UUID) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.export_user_data(UUID) FROM anon;
GRANT EXECUTE ON FUNCTION public.export_user_data(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION public.export_user_data(UUID) TO service_role;
