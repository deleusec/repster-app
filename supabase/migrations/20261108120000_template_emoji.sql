-- A template's picture: a key of the app's Fluent emoji catalogue
-- (`lib/core/emoji`), e.g. `person-lifting-weights`. Nullable: rows written
-- by the PWA or before this column fall back to the muscle group's default.
-- Not constrained to the catalogue so adding an emoji stays an app change.
ALTER TABLE workout_templates ADD COLUMN IF NOT EXISTS emoji TEXT;

-- Snapshot at session start, like `template_name` and `tags`, so history keeps
-- its picture once the template changes or disappears.
ALTER TABLE workout_sessions ADD COLUMN IF NOT EXISTS emoji TEXT;
