-- ============================================================
-- Repster — Call pg_net where pg_net actually lives
-- ------------------------------------------------------------
-- `CREATE EXTENSION pg_net WITH SCHEMA extensions` is accepted, but pg_net
-- ignores it and installs into its own `net` schema. The trigger therefore
-- called `extensions.net.http_post`, which does not exist.
--
-- Nothing looked broken: the exception handler that keeps a failed
-- notification from rejecting a contact message also swallowed this, so the
-- insert succeeded, the queue stayed empty and no mail was ever sent. The
-- handler is still right — a message is worth more than its notification —
-- but the warning it raises is the only trace, so the deployment check below
-- exists to catch the same class of mistake next time.
--
-- Verify after applying: insert a row, then
--   select status_code, error_msg from net._http_response order by created desc;
-- An empty result means the post never left, not that it succeeded.
-- ============================================================

CREATE OR REPLACE FUNCTION public.notify_contact_request()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, net, pg_temp
AS $$
DECLARE
  hook_url    TEXT;
  hook_secret TEXT;
BEGIN
  SELECT decrypted_secret INTO hook_url
  FROM vault.decrypted_secrets WHERE name = 'contact_hook_url';

  SELECT decrypted_secret INTO hook_secret
  FROM vault.decrypted_secrets WHERE name = 'contact_hook_secret';

  IF hook_url IS NULL OR hook_secret IS NULL THEN
    RETURN NULL;
  END IF;

  PERFORM net.http_post(
    url := hook_url,
    headers := jsonb_build_object(
      'Content-Type', 'application/json',
      'x-hook-secret', hook_secret
    ),
    body := jsonb_build_object('record', to_jsonb(NEW)),
    timeout_milliseconds := 5000
  );
  RETURN NULL;
EXCEPTION WHEN OTHERS THEN
  RAISE WARNING 'notify_contact_request failed for %: %', NEW.id, SQLERRM;
  RETURN NULL;
END;
$$;

REVOKE ALL ON FUNCTION public.notify_contact_request() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.notify_contact_request() FROM anon, authenticated;
