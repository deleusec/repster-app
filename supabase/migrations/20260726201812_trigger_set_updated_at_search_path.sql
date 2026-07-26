-- ============================================================
-- Repster — Pin the search_path of trigger_set_updated_at
-- ------------------------------------------------------------
-- Created in the initial schema without a `SET search_path`, so it resolved
-- `now()` through whatever search_path the calling role happened to have.
-- The body is trivial, but the shape is the one behind search-path hijacking:
-- a role that can create a schema earlier in its own search_path can shadow a
-- built-in and have it run inside the trigger.
--
-- Flagged by the Supabase database linter (0011_function_search_path_mutable).
-- The body is unchanged; only the search_path is pinned.
--
-- Used by: set_workout_templates_updated_at BEFORE UPDATE ON workout_templates.
-- ============================================================

CREATE OR REPLACE FUNCTION public.trigger_set_updated_at()
RETURNS TRIGGER
LANGUAGE plpgsql
SET search_path = pg_catalog, pg_temp
AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;
