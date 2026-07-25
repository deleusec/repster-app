-- ============================================================
-- Repster — Session exercises: superset metadata
-- ------------------------------------------------------------
-- Records, per session_exercise, the slot it was performed under and whether
-- it chained into the next slot as a superset. Lets the history view rebuild
-- superset groups for completed sessions. Variants are NOT tracked here:
-- only the performed exercise is stored, so there's nothing to disambiguate.
-- ============================================================

ALTER TABLE session_exercises
  ADD COLUMN IF NOT EXISTS slot_id            UUID,
  ADD COLUMN IF NOT EXISTS superset_with_next BOOLEAN NOT NULL DEFAULT FALSE;

CREATE INDEX IF NOT EXISTS session_exercises_slot_id_idx
  ON session_exercises(slot_id);
