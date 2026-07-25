-- ============================================================
-- Repster — Track `is_active` on workout_templates in migrations
-- ------------------------------------------------------------
-- The column was added directly to the remote (via dashboard) some time ago
-- and the codebase has been relying on it (selects, .eq filters, types). This
-- migration backfills the schema definition so a fresh deploy reproduces the
-- exact remote state. Idempotent via IF NOT EXISTS.
-- ============================================================

ALTER TABLE workout_templates
  ADD COLUMN IF NOT EXISTS is_active BOOLEAN NOT NULL DEFAULT TRUE;
