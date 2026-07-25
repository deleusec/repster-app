-- ============================================================
-- Repster — Certified exercise bank + multilingual names/aliases
-- ------------------------------------------------------------
-- Introduces a global, read-only "Repster" exercise catalog alongside the
-- existing per-user exercises:
--   * exercises.is_certified marks catalog rows; their user_id is NULL and
--     they are readable by every authenticated user (RLS). Users can never
--     insert/update a row as certified (guarded in WITH CHECK) — seeding is
--     done via service role.
--   * exercise_names holds, per exercise, the primary display name for each
--     locale plus any number of aliases/variants/translations. Search matches
--     on ALL of them; the UI shows the primary name in the user's locale.
--   * search_exercises() is an accent-insensitive, trigram-ranked RPC over the
--     catalog + the caller's own exercises (RLS-scoped).
-- ============================================================

-- --- Extensions ---------------------------------------------------------------
CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA extensions;
CREATE EXTENSION IF NOT EXISTS pg_trgm  WITH SCHEMA extensions;

-- Immutable unaccent wrapper (two-arg form pins the dictionary so it can be
-- used inside functional indexes).
CREATE OR REPLACE FUNCTION public.f_unaccent(text)
RETURNS text
LANGUAGE sql IMMUTABLE PARALLEL SAFE STRICT
SET search_path = pg_catalog
AS $$ SELECT extensions.unaccent('extensions.unaccent', $1) $$;

-- --- exercises: certified support --------------------------------------------
ALTER TABLE exercises
  ADD COLUMN IF NOT EXISTS is_certified BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE exercises
  ALTER COLUMN user_id DROP NOT NULL;

-- One certified row per canonical name (case-insensitive). Per-user uniqueness
-- keeps working through the existing exercises_user_id_name_key.
CREATE UNIQUE INDEX IF NOT EXISTS exercises_certified_name_key
  ON exercises (lower(name)) WHERE is_certified;

CREATE INDEX IF NOT EXISTS idx_exercises_is_certified
  ON exercises (is_certified) WHERE is_certified;

-- Certified rows visible to everyone; ownership rules unchanged for the rest.
-- Users can never mark their own rows as certified.
DROP POLICY IF EXISTS "exercises_select" ON exercises;
CREATE POLICY "exercises_select" ON exercises
  FOR SELECT USING (auth.uid() = user_id OR is_certified);

DROP POLICY IF EXISTS "exercises_insert" ON exercises;
CREATE POLICY "exercises_insert" ON exercises
  FOR INSERT WITH CHECK (auth.uid() = user_id AND is_certified = FALSE);

DROP POLICY IF EXISTS "exercises_update" ON exercises;
CREATE POLICY "exercises_update" ON exercises
  FOR UPDATE USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id AND is_certified = FALSE);

-- exercises_delete unchanged: certified rows (user_id NULL) are never deletable
-- by an authenticated user.

-- --- exercise_names: translations / aliases ----------------------------------
CREATE TABLE IF NOT EXISTS exercise_names (
  id          UUID    PRIMARY KEY DEFAULT gen_random_uuid(),
  exercise_id UUID    NOT NULL REFERENCES exercises(id) ON DELETE CASCADE,
  locale      TEXT,   -- 'en' | 'fr' | 'es' | 'de' | 'it' | NULL (language-agnostic alias, e.g. "OHP")
  name        TEXT    NOT NULL,
  is_primary  BOOLEAN NOT NULL DEFAULT FALSE,  -- the display name for (exercise, locale)
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT exercise_names_primary_needs_locale
    CHECK (NOT is_primary OR locale IS NOT NULL)
);

-- At most one primary name per (exercise, locale).
CREATE UNIQUE INDEX IF NOT EXISTS exercise_names_primary_key
  ON exercise_names (exercise_id, locale) WHERE is_primary;

CREATE INDEX IF NOT EXISTS idx_exercise_names_exercise_id
  ON exercise_names (exercise_id);

-- Idempotent seeding: never two identical (exercise, locale, name) rows.
CREATE UNIQUE INDEX IF NOT EXISTS exercise_names_unique_key
  ON exercise_names (exercise_id, COALESCE(locale, ''), name);

-- Accent-insensitive trigram search index over the normalized name.
CREATE INDEX IF NOT EXISTS idx_exercise_names_trgm
  ON exercise_names USING gin (public.f_unaccent(lower(name)) extensions.gin_trgm_ops);

ALTER TABLE exercise_names ENABLE ROW LEVEL SECURITY;

-- Readable whenever the parent exercise is readable (certified or owned).
CREATE POLICY "exercise_names_select" ON exercise_names
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM exercises e
      WHERE e.id = exercise_names.exercise_id
        AND (e.is_certified OR e.user_id = auth.uid())
    )
  );

-- Writable only for the caller's own (non-certified) exercises; certified names
-- are managed via service role.
CREATE POLICY "exercise_names_mutate" ON exercise_names
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM exercises e
      WHERE e.id = exercise_names.exercise_id
        AND e.user_id = auth.uid() AND e.is_certified = FALSE
    )
  ) WITH CHECK (
    EXISTS (
      SELECT 1 FROM exercises e
      WHERE e.id = exercise_names.exercise_id
        AND e.user_id = auth.uid() AND e.is_certified = FALSE
    )
  );

-- --- search_exercises() RPC ---------------------------------------------------
-- Accent-insensitive, trigram-ranked search across every name/alias/translation
-- (exercise_names) plus each exercise's canonical name (covers user exercises
-- that have no exercise_names rows). SECURITY INVOKER → RLS-scoped to certified
-- + caller-owned. Empty query returns the catalog ordered by display name.
CREATE OR REPLACE FUNCTION public.search_exercises(
  p_query  TEXT DEFAULT '',
  p_locale TEXT DEFAULT 'en',
  p_limit  INT  DEFAULT 30
)
RETURNS TABLE (
  id            UUID,
  display_name  TEXT,
  is_certified  BOOLEAN,
  muscle_groups TEXT[],
  category      TEXT,
  matched_via   TEXT,
  score         REAL
)
LANGUAGE sql
STABLE
SET search_path = public, extensions
AS $$
  WITH q AS (
    SELECT public.f_unaccent(lower(btrim(COALESCE(p_query, '')))) AS term
  ),
  terms AS (
    SELECT en.exercise_id, en.name FROM exercise_names en
    UNION ALL
    SELECT e.id, e.name FROM exercises e
  ),
  scored AS (
    SELECT t.exercise_id,
           public.f_unaccent(lower(t.name)) AS n,
           t.name
    FROM terms t, q
    WHERE q.term = ''
       OR public.f_unaccent(lower(t.name)) LIKE '%' || q.term || '%'
       OR public.f_unaccent(lower(t.name)) % q.term
  ),
  agg AS (
    SELECT s.exercise_id,
           max(
             CASE
               WHEN (SELECT term FROM q) = '' THEN 0
               WHEN s.n LIKE (SELECT term FROM q) || '%' THEN 2
               WHEN s.n LIKE '%' || (SELECT term FROM q) || '%' THEN 1
               ELSE 0
             END
             + similarity(s.n, (SELECT term FROM q))
           ) AS score,
           (array_agg(s.name ORDER BY similarity(s.n, (SELECT term FROM q)) DESC))[1] AS matched_via
    FROM scored s
    GROUP BY s.exercise_id
  )
  SELECT e.id,
         COALESCE(
           (SELECT n.name FROM exercise_names n
             WHERE n.exercise_id = e.id AND n.is_primary AND n.locale = p_locale LIMIT 1),
           (SELECT n.name FROM exercise_names n
             WHERE n.exercise_id = e.id AND n.is_primary AND n.locale = 'en' LIMIT 1),
           e.name
         ) AS display_name,
         e.is_certified, e.muscle_groups, e.category,
         a.matched_via,
         a.score::REAL
  FROM agg a
  JOIN exercises e ON e.id = a.exercise_id
  ORDER BY a.score DESC, display_name ASC
  LIMIT p_limit;
$$;

GRANT EXECUTE ON FUNCTION public.search_exercises(TEXT, TEXT, INT) TO authenticated;
