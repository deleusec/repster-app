-- ============================================================
-- Repster — Allow a user to delete their own avatar object
-- ------------------------------------------------------------
-- The `avatars` bucket was created from the dashboard with SELECT (public),
-- INSERT and UPDATE policies, but no DELETE. Removing an avatar in the app
-- could therefore only clear `user_metadata.avatar`; the JPEG stayed in
-- storage, reachable by anyone holding its (guessable) public URL.
--
-- The privacy policy and the terms now promise the file is deleted, so the
-- policy has to exist. Path convention is `<uid>/avatar.jpg`, hence the
-- foldername check — identical to the INSERT/UPDATE policies already in place.
--
-- The three dashboard-created policies are restated here so a fresh
-- environment (`supabase db reset`) ends up with the same rules as production.
-- ============================================================

-- SELECT: avatars are public by design (they are served by <img> from a public
-- bucket URL). Documented as such in the privacy policy, section 10.
DROP POLICY IF EXISTS "Avatars are publicly readable" ON storage.objects;
CREATE POLICY "Avatars are publicly readable" ON storage.objects
  FOR SELECT USING (bucket_id = 'avatars');

DROP POLICY IF EXISTS "Users can upload their own avatar" ON storage.objects;
CREATE POLICY "Users can upload their own avatar" ON storage.objects
  FOR INSERT TO authenticated
  WITH CHECK (
    bucket_id = 'avatars'
    AND (storage.foldername(name))[1] = (SELECT auth.uid())::text
  );

DROP POLICY IF EXISTS "Users can update their own avatar" ON storage.objects;
CREATE POLICY "Users can update their own avatar" ON storage.objects
  FOR UPDATE TO authenticated
  USING (
    bucket_id = 'avatars'
    AND (storage.foldername(name))[1] = (SELECT auth.uid())::text
  );

-- The missing one.
DROP POLICY IF EXISTS "Users can delete their own avatar" ON storage.objects;
CREATE POLICY "Users can delete their own avatar" ON storage.objects
  FOR DELETE TO authenticated
  USING (
    bucket_id = 'avatars'
    AND (storage.foldername(name))[1] = (SELECT auth.uid())::text
  );
