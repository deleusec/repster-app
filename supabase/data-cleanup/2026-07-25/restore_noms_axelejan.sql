-- Sauvegarde avant correction des noms du compte axelejan@gmail.com
-- (eac1b79d-116d-4efd-8cfc-0206001206dc) — projet vbdyzcedymuafiozklze
-- Décodages fournis par cd.deleuse.
--
-- 5 renommages purs :
--   Dev smtih poulie           -> Développé Smith poulie
--   Dev smith haut de pec      -> Développé Smith haut de pec
--   Dev militaire              -> Développé militaire
--   Altère au front            -> Haltères au front
--   Écarté au altère au de pec -> Écarté haltères haut de pec
--
-- 3 fusions (la correction produit un nom déjà pris) :
--   Crunch poulie               <- Crush poulie       (garde l'id de Crush, 19 séries)
--   Développé incliné           <- Développe inclinée (garde l'id d'« incliné », 9 séries)
--   Élévation latérale haltères <- « altérés »        (garde l'id d'« altère », 15 séries)
--
-- Pour annuler : exécuter ce fichier tel quel.
--
-- ⚠ L'ordre des étapes est impératif : rendre son nom au gagnant AVANT de
-- recréer la ligne absorbée, sinon les deux portent le même nom le temps
-- d'une instruction et `exercises_user_id_name_key` rejette l'insertion.

BEGIN;

-- 1) Rendre son nom d'origine à chacun des 8 exos touchés
UPDATE exercises SET name = v.n FROM (VALUES
    ('6afdec71-ee45-47d7-853b-f06d67ac02cd'::uuid,'Dev smtih poulie'),
    ('d83878b4-5f23-441b-991d-343d179119d6','Dev smith haut de pec'),
    ('9c840e89-7b1b-40cc-8661-188cc5755717','Dev militaire'),
    ('3d54490d-b6cf-4258-ad11-43ee1d6b994c','Altère au front'),
    ('2b4223da-d29e-4187-bfc6-5a1fd7e883c8','Écarté au altère au de pec'),
    ('1e751767-a8aa-4638-a833-685252df2b56','Crush poulie'),
    ('9981dfca-b3ab-41b3-b5a7-bbef1b67f305','Développe incliné'),
    ('38c39dc4-fd30-4805-b751-8d6cddb5b62e','Élévation latéral altère')
  ) AS v(id, n) WHERE exercises.id = v.id;

-- 2) Recréer les 3 exos absorbés (les espaces finaux d'origine avaient déjà été
--    retirés par le nettoyage précédent, on restaure la forme détrimée).
INSERT INTO exercises (id, user_id, name, category, muscle_groups, created_at, is_certified) VALUES
  ('8e9804f2-308f-44f0-b143-257853427bbb','eac1b79d-116d-4efd-8cfc-0206001206dc','Crunch poulie',NULL,'{}','2026-01-01T00:00:00+00:00',false),
  ('96390116-38ca-4b81-afe8-9bcdabe19b07','eac1b79d-116d-4efd-8cfc-0206001206dc','Développe inclinée',NULL,'{}','2026-01-01T00:00:00+00:00',false),
  ('5911af6b-b1c0-4fb9-a383-ee2427baa3a8','eac1b79d-116d-4efd-8cfc-0206001206dc','Élévation latéral altérés',NULL,'{}','2026-01-01T00:00:00+00:00',false);

-- 3) Templates : les 3 lignes absorbées repointent vers l'exo recréé
UPDATE template_exercises SET exercise_id = v.ex FROM (VALUES
    ('d121e41b-9a66-46e3-98f3-fcf73b0138f4'::uuid,'8e9804f2-308f-44f0-b143-257853427bbb'::uuid),
    ('b2f099c9-ce4d-4d79-9268-d8d67fcdfcfc','96390116-38ca-4b81-afe8-9bcdabe19b07'),
    ('63198868-7322-45c7-8b66-b47fc68c7329','5911af6b-b1c0-4fb9-a383-ee2427baa3a8')
  ) AS v(id, ex) WHERE template_exercises.id = v.id;

-- 4) Historique : exercise_id + name d'origine, ligne par ligne
UPDATE session_exercises se SET exercise_id = v.ex, name = v.n FROM (VALUES
    ('bf6c04aa-6b4c-4462-a8d0-a980de557064'::uuid,'9981dfca-b3ab-41b3-b5a7-bbef1b67f305'::uuid,'Développe incliné'),
    ('b342383c-b219-44ce-afe3-87f4670464ab','9981dfca-b3ab-41b3-b5a7-bbef1b67f305','Développe incliné'),
    ('419a5d7e-50f5-442f-b7c0-5f32fe5f3e17','9981dfca-b3ab-41b3-b5a7-bbef1b67f305','Développe incliné'),
    ('8458b19d-a149-4e18-bb01-2aaf48342b69','96390116-38ca-4b81-afe8-9bcdabe19b07','Développe inclinée'),
    ('ad526250-58d1-48fd-b611-14f89b8bf327','38c39dc4-fd30-4805-b751-8d6cddb5b62e','Élévation latéral altère'),
    ('180b2b9d-6a29-41a9-931b-b0915303a006','38c39dc4-fd30-4805-b751-8d6cddb5b62e','Élévation latéral altère'),
    ('85882853-c54a-43e7-b109-7265d0cdb339','38c39dc4-fd30-4805-b751-8d6cddb5b62e','Élévation latéral altère'),
    ('7ab6ce38-4152-4aa4-aa04-5ef6e8258850','38c39dc4-fd30-4805-b751-8d6cddb5b62e','Élévation latéral altère'),
    ('76860462-a479-45b6-bc48-93cf241e02b0','38c39dc4-fd30-4805-b751-8d6cddb5b62e','Élévation latéral altère'),
    ('49388050-85ff-48ed-ab0a-b96cad0624f1','1e751767-a8aa-4638-a833-685252df2b56','Crush poulie'),
    ('0f0e9981-fce6-453c-8967-82dff444da7b','1e751767-a8aa-4638-a833-685252df2b56','Crush poulie'),
    ('82b189e6-d4b2-40be-8ed6-3b40238a89d5','1e751767-a8aa-4638-a833-685252df2b56','Crush poulie'),
    ('1ca52f39-7cd7-4b02-9004-ae5595964e16','1e751767-a8aa-4638-a833-685252df2b56','Crush poulie'),
    ('ee6e8e6e-5cb3-42dd-b565-c891f64f3523','1e751767-a8aa-4638-a833-685252df2b56','Crush poulie'),
    ('efc61c3a-1363-46d5-a190-009cbae3ed13','8e9804f2-308f-44f0-b143-257853427bbb','Crunch poulie')
  ) AS v(id, ex, n) WHERE se.id = v.id;

COMMIT;
