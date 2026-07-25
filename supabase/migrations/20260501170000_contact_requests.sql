-- ============================================================
-- Repster — Contact requests (support / feedback inbox)
-- ============================================================
-- Stores messages submitted from the in-app Contact page.
--
--   • user_id   : optional FK to auth.users — kept nullable so
--                 the row survives account deletion (we want to
--                 retain support history) and so anonymous /
--                 logged-out submissions remain possible.
--   • category  : constrained to the four UI choices.
--
-- RLS : authenticated users can only INSERT their own request
-- (or a fully anonymous one). They cannot SELECT/UPDATE/DELETE.
-- The inbox is read-only via the service role from the dashboard.
-- ============================================================

CREATE TABLE IF NOT EXISTS contact_requests (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID        REFERENCES auth.users(id) ON DELETE SET NULL,
  name        TEXT        NOT NULL,
  email       TEXT        NOT NULL,
  category    TEXT        NOT NULL
              CHECK (category IN ('bug', 'feature', 'general', 'other')),
  message     TEXT        NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_contact_requests_created_at
  ON contact_requests(created_at DESC);

CREATE INDEX IF NOT EXISTS idx_contact_requests_user_id
  ON contact_requests(user_id);

ALTER TABLE contact_requests ENABLE ROW LEVEL SECURITY;

-- Users can submit a request as themselves, or anonymously.
CREATE POLICY "contact_requests_insert" ON contact_requests
  FOR INSERT WITH CHECK (
    user_id IS NULL OR user_id = auth.uid()
  );
