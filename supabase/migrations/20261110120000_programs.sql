-- ============================================================
-- Repster — Programs: folders of sessions, one of them active
-- ------------------------------------------------------------
-- A program groups workout templates ("sessions"). A template belongs to at
-- most one program (`workout_templates.program_id`), or to none.
--
-- `workout_templates.is_active` stays the single truth the dashboard reads,
-- and the only flag the PWA knows: it keeps working untouched, its templates
-- simply have no program. Activating a program is a bulk write to that flag
-- (`set_active_program`), after which a session can still be switched on or
-- off on its own.
-- ============================================================

CREATE TABLE IF NOT EXISTS programs (
  id         UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name       TEXT        NOT NULL CHECK (length(btrim(name)) BETWEEN 1 AND 80),
  position   INT         NOT NULL DEFAULT 0,
  is_active  BOOLEAN     NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  -- Target of the composite foreign key below.
  UNIQUE (id, user_id)
);

CREATE INDEX IF NOT EXISTS idx_programs_user_position
  ON programs(user_id, position);

-- At most one active program per user.
CREATE UNIQUE INDEX IF NOT EXISTS programs_one_active_per_user
  ON programs(user_id) WHERE is_active;

CREATE TRIGGER set_programs_updated_at
  BEFORE UPDATE ON programs
  FOR EACH ROW EXECUTE FUNCTION trigger_set_updated_at();

ALTER TABLE programs ENABLE ROW LEVEL SECURITY;

CREATE POLICY "programs_select" ON programs
  FOR SELECT TO authenticated USING ((SELECT auth.uid()) = user_id);

CREATE POLICY "programs_insert" ON programs
  FOR INSERT TO authenticated WITH CHECK ((SELECT auth.uid()) = user_id);

CREATE POLICY "programs_update" ON programs
  FOR UPDATE TO authenticated
  USING ((SELECT auth.uid()) = user_id)
  WITH CHECK ((SELECT auth.uid()) = user_id);

CREATE POLICY "programs_delete" ON programs
  FOR DELETE TO authenticated USING ((SELECT auth.uid()) = user_id);

-- ─── Membership ───────────────────────────────────────────────────────────────

ALTER TABLE workout_templates ADD COLUMN IF NOT EXISTS program_id UUID;

-- Composite, so a template can only point at a program of the same user.
-- Deleting a program releases its sessions instead of deleting them.
ALTER TABLE workout_templates
  ADD CONSTRAINT workout_templates_program_fk
  FOREIGN KEY (program_id, user_id) REFERENCES programs(id, user_id)
  ON DELETE SET NULL (program_id);

CREATE INDEX IF NOT EXISTS idx_workout_templates_program
  ON workout_templates(program_id) WHERE program_id IS NOT NULL;

-- ─── Activation ───────────────────────────────────────────────────────────────

-- Switches a program on or off, and its sessions with it, in one transaction.
-- Turning one on turns the other programs' sessions off; sessions outside any
-- program are left alone. SECURITY INVOKER: RLS confines every statement to
-- the caller's rows.
CREATE OR REPLACE FUNCTION public.set_active_program(
  p_program_id UUID,
  p_active BOOLEAN DEFAULT TRUE
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY INVOKER
SET search_path = public, pg_temp
AS $$
DECLARE
  uid UUID := auth.uid();
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM programs WHERE id = p_program_id AND user_id = uid
  ) THEN
    RAISE EXCEPTION 'set_active_program: program not found';
  END IF;

  IF p_active THEN
    -- Off before on: the partial unique index allows one active row.
    UPDATE programs SET is_active = FALSE
      WHERE user_id = uid AND is_active AND id <> p_program_id;
    UPDATE programs SET is_active = TRUE
      WHERE id = p_program_id AND NOT is_active;
    UPDATE workout_templates SET is_active = (program_id = p_program_id)
      WHERE user_id = uid
        AND program_id IS NOT NULL
        AND is_active <> (program_id = p_program_id);
  ELSE
    UPDATE programs SET is_active = FALSE
      WHERE id = p_program_id AND is_active;
    UPDATE workout_templates SET is_active = FALSE
      WHERE user_id = uid AND program_id = p_program_id AND is_active;
  END IF;
END;
$$;

REVOKE ALL ON FUNCTION public.set_active_program(UUID, BOOLEAN) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.set_active_program(UUID, BOOLEAN) TO authenticated;

-- ─── Export ───────────────────────────────────────────────────────────────────

-- Same function as 20260726200542, with the programs added to the export.
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
    'programs', (
      SELECT COALESCE(jsonb_agg(to_jsonb(p) ORDER BY p.position), '[]'::jsonb)
      FROM programs p
      WHERE p.user_id = uid
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
