-- ============================================================
-- Repster — Initial Schema
-- Run this in the Supabase SQL Editor (Dashboard → SQL Editor)
-- ============================================================

-- ─── Extensions ───────────────────────────────────────────────────────────────

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ─── Tables ───────────────────────────────────────────────────────────────────

-- Exercise library (per user)
CREATE TABLE IF NOT EXISTS exercises (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id      UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name         TEXT        NOT NULL,
  category     TEXT,
  muscle_groups TEXT[]     DEFAULT '{}',
  created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (user_id, name)
);

-- Workout templates (per user)
CREATE TABLE IF NOT EXISTS workout_templates (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name        TEXT        NOT NULL,
  description TEXT,
  tags        TEXT[]      NOT NULL DEFAULT '{}',
  position    INT         NOT NULL DEFAULT 0,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Exercises inside a template (ordered)
CREATE TABLE IF NOT EXISTS template_exercises (
  id           UUID  PRIMARY KEY DEFAULT gen_random_uuid(),
  template_id  UUID  NOT NULL REFERENCES workout_templates(id) ON DELETE CASCADE,
  exercise_id  UUID  NOT NULL REFERENCES exercises(id) ON DELETE CASCADE,
  position     INT   NOT NULL DEFAULT 0,
  sets_count   INT   NOT NULL DEFAULT 3,
  reps_target  INT   NOT NULL DEFAULT 10,
  tempo        TEXT,
  rest_seconds INT,
  notes        TEXT
);

-- Completed workout sessions
CREATE TABLE IF NOT EXISTS workout_sessions (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id          UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  -- nullable so sessions survive template deletion
  template_id      UUID        REFERENCES workout_templates(id) ON DELETE SET NULL,
  template_name    TEXT        NOT NULL,           -- snapshot
  tags             TEXT[]      NOT NULL DEFAULT '{}', -- snapshot
  started_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  completed_at     TIMESTAMPTZ,
  duration_seconds INT,
  notes            TEXT
);

-- Snapshot of exercises at session time
CREATE TABLE IF NOT EXISTS session_exercises (
  id          UUID  PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id  UUID  NOT NULL REFERENCES workout_sessions(id) ON DELETE CASCADE,
  -- nullable so history survives exercise deletion
  exercise_id UUID  REFERENCES exercises(id) ON DELETE SET NULL,
  name        TEXT  NOT NULL,  -- snapshot
  position    INT   NOT NULL DEFAULT 0,
  notes       TEXT
);

-- Each set performed during a session
CREATE TABLE IF NOT EXISTS session_sets (
  id                   UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  session_exercise_id  UUID        NOT NULL REFERENCES session_exercises(id) ON DELETE CASCADE,
  set_number           INT         NOT NULL,
  reps_target          INT,
  reps_performed       INT,
  weight_kg            NUMERIC(6, 2),
  tempo                TEXT,
  completed_at         TIMESTAMPTZ
);

-- ─── Indexes ──────────────────────────────────────────────────────────────────

CREATE INDEX IF NOT EXISTS idx_exercises_user_id
  ON exercises(user_id);

CREATE INDEX IF NOT EXISTS idx_workout_templates_user_position
  ON workout_templates(user_id, position);

CREATE INDEX IF NOT EXISTS idx_template_exercises_template_id
  ON template_exercises(template_id);

CREATE INDEX IF NOT EXISTS idx_workout_sessions_user_started
  ON workout_sessions(user_id, started_at DESC);

CREATE INDEX IF NOT EXISTS idx_session_exercises_session_id
  ON session_exercises(session_id);

CREATE INDEX IF NOT EXISTS idx_session_sets_session_exercise_id
  ON session_sets(session_exercise_id);

-- ─── updated_at trigger ───────────────────────────────────────────────────────

CREATE OR REPLACE FUNCTION trigger_set_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;

CREATE TRIGGER set_workout_templates_updated_at
  BEFORE UPDATE ON workout_templates
  FOR EACH ROW EXECUTE FUNCTION trigger_set_updated_at();

-- ─── Row Level Security ───────────────────────────────────────────────────────

ALTER TABLE exercises          ENABLE ROW LEVEL SECURITY;
ALTER TABLE workout_templates  ENABLE ROW LEVEL SECURITY;
ALTER TABLE template_exercises ENABLE ROW LEVEL SECURITY;
ALTER TABLE workout_sessions   ENABLE ROW LEVEL SECURITY;
ALTER TABLE session_exercises  ENABLE ROW LEVEL SECURITY;
ALTER TABLE session_sets       ENABLE ROW LEVEL SECURITY;

-- exercises: direct ownership
CREATE POLICY "exercises_select" ON exercises
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "exercises_insert" ON exercises
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "exercises_update" ON exercises
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "exercises_delete" ON exercises
  FOR DELETE USING (auth.uid() = user_id);

-- workout_templates: direct ownership
CREATE POLICY "templates_select" ON workout_templates
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "templates_insert" ON workout_templates
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "templates_update" ON workout_templates
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "templates_delete" ON workout_templates
  FOR DELETE USING (auth.uid() = user_id);

-- template_exercises: access via template ownership
CREATE POLICY "template_exercises_select" ON template_exercises
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM workout_templates t
      WHERE t.id = template_id AND t.user_id = auth.uid()
    )
  );

CREATE POLICY "template_exercises_insert" ON template_exercises
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM workout_templates t
      WHERE t.id = template_id AND t.user_id = auth.uid()
    )
  );

CREATE POLICY "template_exercises_update" ON template_exercises
  FOR UPDATE USING (
    EXISTS (
      SELECT 1 FROM workout_templates t
      WHERE t.id = template_id AND t.user_id = auth.uid()
    )
  );

CREATE POLICY "template_exercises_delete" ON template_exercises
  FOR DELETE USING (
    EXISTS (
      SELECT 1 FROM workout_templates t
      WHERE t.id = template_id AND t.user_id = auth.uid()
    )
  );

-- workout_sessions: direct ownership
CREATE POLICY "sessions_select" ON workout_sessions
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "sessions_insert" ON workout_sessions
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "sessions_update" ON workout_sessions
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "sessions_delete" ON workout_sessions
  FOR DELETE USING (auth.uid() = user_id);

-- session_exercises: access via session ownership
CREATE POLICY "session_exercises_select" ON session_exercises
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM workout_sessions s
      WHERE s.id = session_id AND s.user_id = auth.uid()
    )
  );

CREATE POLICY "session_exercises_insert" ON session_exercises
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM workout_sessions s
      WHERE s.id = session_id AND s.user_id = auth.uid()
    )
  );

CREATE POLICY "session_exercises_delete" ON session_exercises
  FOR DELETE USING (
    EXISTS (
      SELECT 1 FROM workout_sessions s
      WHERE s.id = session_id AND s.user_id = auth.uid()
    )
  );

-- session_sets: access via session_exercise → session ownership
CREATE POLICY "session_sets_select" ON session_sets
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM session_exercises se
      JOIN workout_sessions s ON s.id = se.session_id
      WHERE se.id = session_exercise_id AND s.user_id = auth.uid()
    )
  );

CREATE POLICY "session_sets_insert" ON session_sets
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM session_exercises se
      JOIN workout_sessions s ON s.id = se.session_id
      WHERE se.id = session_exercise_id AND s.user_id = auth.uid()
    )
  );

CREATE POLICY "session_sets_delete" ON session_sets
  FOR DELETE USING (
    EXISTS (
      SELECT 1 FROM session_exercises se
      JOIN workout_sessions s ON s.id = se.session_id
      WHERE se.id = session_exercise_id AND s.user_id = auth.uid()
    )
  );
