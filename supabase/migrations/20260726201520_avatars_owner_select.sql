-- ============================================================
-- Repster — Give the owner back SELECT on their own avatar
-- ------------------------------------------------------------
-- 20260726203000 dropped the bucket-wide SELECT policy to stop anonymous
-- enumeration. It worked — anon went from 3 listable objects to 0, and the
-- public object URL keeps serving the image, since a public bucket is read
-- through `/object/public/...` which does not evaluate RLS.
--
-- But it also left the *owner* unable to see their own row:
--   set local role authenticated;
--   set local request.jwt.claims = '{"sub":"<uid>","role":"authenticated"}';
--   select count(*) from storage.objects where name like '<uid>%';   -- 0
--
-- Storage resolves an upsert and a delete against the caller's own view of
-- storage.objects, so "change my avatar" and "remove my avatar" were both
-- resting on visibility that no longer existed. Narrow SELECT restores
-- exactly what the owner needs and nothing more: anon still enumerates
-- nothing, and one user cannot list another's folder.
-- ============================================================

DROP POLICY IF EXISTS "Users can read their own avatar" ON storage.objects;
CREATE POLICY "Users can read their own avatar" ON storage.objects
  FOR SELECT TO authenticated
  USING (
    bucket_id = 'avatars'
    AND (storage.foldername(name))[1] = (SELECT auth.uid())::text
  );
