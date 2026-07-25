-- ============================================================
-- Repster — In-progress sessions (resume unfinished workouts)
-- ============================================================
-- Adds two columns to workout_sessions to allow surviving an
-- unfinished session across browser/device closures:
--   • live_snapshot   : full Zustand-style snapshot serialised
--                       as JSONB. NULL once the session is
--                       finalised (completed_at IS NOT NULL).
--   • live_updated_at : last time the snapshot was synced.
--
-- Application invariant : a user has at most one in-progress
-- session at a time (completed_at IS NULL). Enforced in the
-- server actions by deleting the existing row before inserting
-- a new one.
-- ============================================================

ALTER TABLE workout_sessions
  ADD COLUMN IF NOT EXISTS live_snapshot   JSONB,
  ADD COLUMN IF NOT EXISTS live_updated_at TIMESTAMPTZ;

-- Fast lookup of the in-progress session of a user
CREATE INDEX IF NOT EXISTS idx_workout_sessions_user_unfinished
  ON workout_sessions(user_id, live_updated_at DESC)
  WHERE completed_at IS NULL;
