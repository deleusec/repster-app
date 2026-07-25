-- ============================================================
-- Repster — Template Variants & Supersets
-- Adds support for:
--   1. Variant exercises within a template slot (alternates the user can
--      switch between in the live session).
--   2. Linking consecutive slots as a superset/biset block.
-- ============================================================

ALTER TABLE template_exercises
  ADD COLUMN IF NOT EXISTS slot_id            UUID    NOT NULL DEFAULT gen_random_uuid(),
  ADD COLUMN IF NOT EXISTS variant_position   INT     NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS superset_with_next BOOLEAN NOT NULL DEFAULT FALSE;

-- All variants of a slot share the same slot_id; lookups group by it.
CREATE INDEX IF NOT EXISTS template_exercises_slot_id_idx
  ON template_exercises(slot_id);

-- Existing rows keep their default (each becomes its own single-variant slot,
-- with superset_with_next = false), so the migration is non-destructive.
