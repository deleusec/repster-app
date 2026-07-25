-- Sauvegarde avant les accords + 4 fusions du compte axelejan@gmail.com
-- (eac1b79d-116d-4efd-8cfc-0206001206dc) — projet vbdyzcedymuafiozklze
--
-- 3 renommages purs :
--   Tirage verticale biceps    -> Tirage vertical biceps
--   Triceps poulie unilatérale -> Triceps poulie unilatéral
--   Rowing poitrine appuyés    -> Rowing poitrine appuyée
--
-- 4 fusions (gagnant = celui qui porte le plus d'historique) :
--   Élévation latérale poulie    <- « latéral poulie »  (garde 47aedd22, 15 séries)
--   Tirage vertical prise neutre <- « verticale »        (garde 0a277384, 20 séries)
--   Écartés inclinés             <- « inclinée »+« inclinées » (garde 1b1720f4, 9 séries)
--   Relevés de jambes            <- « Relevé de jambes » (garde 7564e939, 15 séries)
--
-- Pour annuler : exécuter ce fichier tel quel.
--
-- ⚠ L'ordre des étapes est impératif : rendre son nom au gagnant AVANT de
-- recréer la ligne absorbée, sinon les deux portent le même nom le temps
-- d'une instruction et `exercises_user_id_name_key` rejette l'insertion.

BEGIN;

-- 1) Rendre son nom d'origine à chaque exo touché
UPDATE exercises SET name = v.n FROM (VALUES
    ('8d4fb2de-6160-45df-8f36-092ec57f4f9d'::uuid,'Tirage verticale biceps'),
    ('95b920ee-a2ef-4b93-8d93-c3d111ecb8e6','Triceps poulie unilatérale'),
    ('7875f8f8-101d-4c03-ba43-a9ede93fa7b5','Rowing poitrine appuyés'),
    ('47aedd22-48b4-40d8-a1e6-494d5e5ce99b','Élévation latéral poulie'),
    ('0a277384-d196-4e0d-9a62-9f8c7702fbf6','Tirage vertical prise neutre'),
    ('1b1720f4-2e71-4e4a-9672-d4b715ebbaeb','Écartés inclinée'),
    ('7564e939-c07c-4e0c-959f-308c43e36cf9','Relevé de jambes')
  ) AS v(id, n) WHERE exercises.id = v.id;

-- 2) Recréer les 4 exos absorbés
INSERT INTO exercises (id, user_id, name, category, muscle_groups, created_at, is_certified) VALUES
  ('70ddfe90-881a-4bf5-b464-1a005f4ab3eb','eac1b79d-116d-4efd-8cfc-0206001206dc','Élévation latérale poulie',NULL,'{}','2026-01-01T00:00:00+00:00',false),
  ('cc438db1-6668-4e3b-a078-55ee3f92b544','eac1b79d-116d-4efd-8cfc-0206001206dc','Tirage verticale prise neutre',NULL,'{}','2026-01-01T00:00:00+00:00',false),
  ('16d55eb0-a97e-4790-a81c-417cd6749fd4','eac1b79d-116d-4efd-8cfc-0206001206dc','Écartés inclinées',NULL,'{}','2026-01-01T00:00:00+00:00',false),
  ('cb5d81d2-6861-4d37-ade2-0f6c3bd42854','eac1b79d-116d-4efd-8cfc-0206001206dc','Relevés de jambes',NULL,'{}','2026-01-01T00:00:00+00:00',false);

-- 3) Templates : les 4 lignes absorbées repointent vers l'exo recréé
UPDATE template_exercises SET exercise_id = v.ex FROM (VALUES
    ('174dbead-e3aa-4e0e-9d66-ef432847cea7'::uuid,'70ddfe90-881a-4bf5-b464-1a005f4ab3eb'::uuid),
    ('5198bb0a-2a33-4f88-bba6-35376449f971','cc438db1-6668-4e3b-a078-55ee3f92b544'),
    ('c597cab5-2735-4e9d-8915-343b7d829bbf','16d55eb0-a97e-4790-a81c-417cd6749fd4'),
    ('dbe7acd0-a790-4140-b358-d829ccc6c0a8','cb5d81d2-6861-4d37-ade2-0f6c3bd42854')
  ) AS v(id, ex) WHERE template_exercises.id = v.id;

-- 4) Historique : exercise_id + name d'origine, ligne par ligne (31 lignes)
UPDATE session_exercises se SET exercise_id = v.ex, name = v.n FROM (VALUES
    ('abf812e1-b5a7-470f-b91e-241eb518f077'::uuid,'47aedd22-48b4-40d8-a1e6-494d5e5ce99b'::uuid,'Élévation latéral poulie'),
    ('437ec782-c4f3-4b74-b1bc-2bab5e020df9','47aedd22-48b4-40d8-a1e6-494d5e5ce99b','Élévation latéral poulie'),
    ('765b3227-24a5-46b8-91f0-93beca516cfa','47aedd22-48b4-40d8-a1e6-494d5e5ce99b','Élévation latéral poulie'),
    ('bba3329d-95f9-401c-a6cc-dbc0e5923ecc','47aedd22-48b4-40d8-a1e6-494d5e5ce99b','Élévation latéral poulie'),
    ('1e0fb0ff-3b5e-4ac9-b319-a2998e318e00','47aedd22-48b4-40d8-a1e6-494d5e5ce99b','Élévation latéral poulie'),
    ('25a65638-9f66-4ca9-8300-43cd70feaa48','70ddfe90-881a-4bf5-b464-1a005f4ab3eb','Élévation latérale poulie'),
    ('bc951d23-950f-4b9c-95e4-8e966cf272ad','70ddfe90-881a-4bf5-b464-1a005f4ab3eb','Élévation latérale poulie'),
    ('334f49b9-cc25-46a6-9bb9-287fc9d0f368','70ddfe90-881a-4bf5-b464-1a005f4ab3eb','Élévation latérale poulie'),
    ('d6b5df03-108a-4b9a-bbfc-83f5cb1cb687','0a277384-d196-4e0d-9a62-9f8c7702fbf6','Tirage vertical prise neutre'),
    ('8a54261d-ce0a-4067-beef-23c1e9074510','0a277384-d196-4e0d-9a62-9f8c7702fbf6','Tirage vertical prise neutre'),
    ('ea884705-7ba4-40c6-8b47-02db3e4fd41e','0a277384-d196-4e0d-9a62-9f8c7702fbf6','Tirage vertical prise neutre'),
    ('10f748ab-c061-4eda-8352-989641e53d66','0a277384-d196-4e0d-9a62-9f8c7702fbf6','Tirage vertical prise neutre'),
    ('6ac5a79c-fd6c-4855-98f4-807d5b659bc6','0a277384-d196-4e0d-9a62-9f8c7702fbf6','Tirage vertical prise neutre'),
    ('82e33e21-0a14-40fb-ab06-c162c97fc3b7','cc438db1-6668-4e3b-a078-55ee3f92b544','Tirage verticale prise neutre'),
    ('acbcde9e-8953-4204-833e-21e79d75b2d0','cc438db1-6668-4e3b-a078-55ee3f92b544','Tirage verticale prise neutre'),
    ('47b1d59c-ac19-491d-8468-5d4b34309c93','cc438db1-6668-4e3b-a078-55ee3f92b544','Tirage verticale prise neutre'),
    ('68188518-fba9-492f-a909-41160b726e4c','cc438db1-6668-4e3b-a078-55ee3f92b544','Tirage verticale prise neutre'),
    ('d96e5d01-8205-4440-9e1a-a0658890b25a','1b1720f4-2e71-4e4a-9672-d4b715ebbaeb','Écartés inclinée'),
    ('7ad56d63-3e91-404f-917f-b532c94bdc51','1b1720f4-2e71-4e4a-9672-d4b715ebbaeb','Écartés inclinée'),
    ('ed3d59ed-58c5-43fd-8899-7611ebaa0f46','1b1720f4-2e71-4e4a-9672-d4b715ebbaeb','Écartés inclinée'),
    ('675ce49d-6290-456a-b86d-d6e38991c65a','16d55eb0-a97e-4790-a81c-417cd6749fd4','Écartés inclinées'),
    ('745d38a4-53cc-455e-b37d-ea740e5eab68','7564e939-c07c-4e0c-959f-308c43e36cf9','Relevé de jambes'),
    ('074ad819-f0de-4645-b6b0-f36e355f2811','7564e939-c07c-4e0c-959f-308c43e36cf9','Relevé de jambes'),
    ('2b2c12f3-994b-4088-8cbb-7f4d8af8ec88','7564e939-c07c-4e0c-959f-308c43e36cf9','Relevé de jambes'),
    ('4450405b-f581-4d1f-9d67-e2869b272763','7564e939-c07c-4e0c-959f-308c43e36cf9','Relevé de jambes'),
    ('e83d5c28-c519-4b94-afbd-e48f63b1b878','7564e939-c07c-4e0c-959f-308c43e36cf9','Relevé de jambes'),
    ('eba8e0a5-c8b7-454e-a0d3-325e0b7233d4','cb5d81d2-6861-4d37-ade2-0f6c3bd42854','Relevés de jambes'),
    ('8db63f1d-fdd7-405e-aa51-1a16bc101840','7875f8f8-101d-4c03-ba43-a9ede93fa7b5','Rowing poitrine appuyés'),
    ('c2a76f19-6eae-4990-bac1-b66311f6fee9','7875f8f8-101d-4c03-ba43-a9ede93fa7b5','Rowing poitrine appuyés'),
    ('2ffbc957-180d-4995-b627-f0d84f3b5e8c','7875f8f8-101d-4c03-ba43-a9ede93fa7b5','Rowing poitrine appuyés'),
    ('78571c28-5b53-4c0a-8ebe-f5793b3e4ce1','7875f8f8-101d-4c03-ba43-a9ede93fa7b5','Rowing poitrine appuyés')
  ) AS v(id, ex, n) WHERE se.id = v.id;

COMMIT;
