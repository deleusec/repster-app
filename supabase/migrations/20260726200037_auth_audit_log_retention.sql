-- ============================================================
-- Repster — 12-month retention for authentication logs
-- ------------------------------------------------------------
-- The privacy policy (section 8) states that authentication logs are kept
-- "12 months maximum". Nothing enforced it: `auth.audit_log_entries` grows
-- forever, so the stated retention was a promise the database did not keep.
--
-- A weekly pg_cron job now trims it. The function is SECURITY DEFINER because
-- the `auth` schema is not writable by the roles the API runs as, and its
-- EXECUTE right is revoked from everyone but the job owner.
-- ============================================================

CREATE EXTENSION IF NOT EXISTS pg_cron;

CREATE OR REPLACE FUNCTION public.purge_auth_audit_logs()
RETURNS integer
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = pg_catalog, auth, pg_temp
AS $$
DECLARE
  deleted integer;
BEGIN
  DELETE FROM auth.audit_log_entries
  WHERE created_at < now() - interval '12 months';
  GET DIAGNOSTICS deleted = ROW_COUNT;
  RETURN deleted;
END;
$$;

COMMENT ON FUNCTION public.purge_auth_audit_logs() IS
  'Enforces the 12-month authentication-log retention announced in the '
  'privacy policy (section 8). Scheduled weekly via pg_cron.';

-- Housekeeping only: nothing in the app may call this.
REVOKE ALL ON FUNCTION public.purge_auth_audit_logs() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.purge_auth_audit_logs() FROM anon, authenticated;

-- Re-schedulable: unschedule first so re-running the migration is harmless.
SELECT cron.unschedule('purge-auth-audit-logs')
WHERE EXISTS (SELECT 1 FROM cron.job WHERE jobname = 'purge-auth-audit-logs');

-- Sundays at 03:00 UTC — the traffic trough, and weekly is plenty for a
-- 12-month window.
SELECT cron.schedule(
  'purge-auth-audit-logs',
  '0 3 * * 0',
  $$SELECT public.purge_auth_audit_logs()$$
);
