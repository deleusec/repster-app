-- ============================================================
-- Repster — Tell a human when a contact request arrives
-- ------------------------------------------------------------
-- The contact form wrote a row and stopped there. Nothing notified anyone, so
-- three messages sat unread for up to nine weeks — on a service whose privacy
-- policy and terms promise an answer within one month, and whose account
-- deletion procedure tells people to write in.
--
-- An AFTER INSERT trigger now posts the row to the `on-contact-request` edge
-- function, which emails it. Two properties matter more than the delivery:
--
--   * The insert must never fail because the notification did. `net.http_post`
--     only queues the request, and the whole body is wrapped anyway — losing a
--     message to protect a mail is the wrong trade.
--   * The table stays the record of truth. The mail is a convenience; the GDPR
--     runbook still reads `contact_requests`.
--
-- Secrets live in Vault, not in this file: `contact_hook_url` and
-- `contact_hook_secret`. Until both exist the trigger is inert — it returns
-- without posting — so this migration is safe to apply before they are set.
-- ============================================================

CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;

CREATE OR REPLACE FUNCTION public.notify_contact_request()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, extensions, pg_temp
AS $$
DECLARE
  hook_url    TEXT;
  hook_secret TEXT;
BEGIN
  SELECT decrypted_secret INTO hook_url
  FROM vault.decrypted_secrets WHERE name = 'contact_hook_url';

  SELECT decrypted_secret INTO hook_secret
  FROM vault.decrypted_secrets WHERE name = 'contact_hook_secret';

  -- Not configured yet: the row is saved, nobody is told. Deliberate — this
  -- is the state between applying the migration and setting the secrets.
  IF hook_url IS NULL OR hook_secret IS NULL THEN
    RETURN NULL;
  END IF;

  PERFORM extensions.net.http_post(
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
  -- A contact message is worth more than its notification.
  RAISE WARNING 'notify_contact_request failed for %: %', NEW.id, SQLERRM;
  RETURN NULL;
END;
$$;

COMMENT ON FUNCTION public.notify_contact_request() IS
  'Posts a new contact_requests row to the on-contact-request edge function. '
  'Inert until the contact_hook_url and contact_hook_secret Vault secrets '
  'exist. Never fails the insert.';

REVOKE ALL ON FUNCTION public.notify_contact_request() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.notify_contact_request() FROM anon, authenticated;

DROP TRIGGER IF EXISTS contact_request_notify ON contact_requests;
CREATE TRIGGER contact_request_notify
  AFTER INSERT ON contact_requests
  FOR EACH ROW EXECUTE FUNCTION public.notify_contact_request();
