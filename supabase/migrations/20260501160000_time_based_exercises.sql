-- ============================================================
-- Repster — Time-based exercises (e.g. dead hang, plank)
-- Adds an `is_time_based` flag + duration columns so a set can
-- be measured in seconds instead of reps.
-- ============================================================

-- Template exercises: per-exercise default
ALTER TABLE template_exercises
  ADD COLUMN IF NOT EXISTS is_time_based   BOOLEAN NOT NULL DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS duration_seconds INT;

-- Allow reps_target to be NULL for time-based exercises
ALTER TABLE template_exercises
  ALTER COLUMN reps_target DROP NOT NULL;

-- Session-level snapshot of the time-based flag (so swapping/editing
-- mid-session doesn't fight the template).
ALTER TABLE session_exercises
  ADD COLUMN IF NOT EXISTS is_time_based BOOLEAN NOT NULL DEFAULT FALSE;

-- Session sets: store target / performed duration alongside reps
ALTER TABLE session_sets
  ADD COLUMN IF NOT EXISTS duration_target_seconds    INT,
  ADD COLUMN IF NOT EXISTS duration_performed_seconds INT;
