-- Sauvegarde avant fusion « classe C » — projet vbdyzcedymuafiozklze
-- Compte cd.deleuse@gmail.com. Arbitrages validés par l'utilisateur.
--
--   Tirage horizontal unilatéral poulie <- Tirage horizontal unilatéral
--   Rowing Matrix                       <- Rowing Matrix Neutre
--   Relevés de jambes à la barre        <- Relevé de jambes,
--                                          Relevés de jambes suspendu
--
-- Écartés poulie (les 3) : volontairement NON fusionnés.
-- Non retenus : Chest Press / convergente, les 2 extensions triceps
-- unilatérales, Tirage vertical prise neutre unilatéral.
--
-- Pour annuler : exécuter ce fichier tel quel. Il recrée les 4 exos perdants
-- avec leurs id d'origine, puis rend à chacune des 15 lignes d'historique son
-- exercise_id et son name d'avant.

BEGIN;

INSERT INTO exercises (id, user_id, name, category, muscle_groups, created_at, is_certified) VALUES
  ('dd03c50f-2ae3-4293-b6bc-5043410b0f16','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Tirage horizontal unilatéral',NULL,'{}','2026-06-12T20:09:00.972381+00:00',false),
  ('59a47b29-168b-4181-b415-b33fa4a434ef','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Rowing Matrix Neutre',NULL,'{}','2026-06-18T18:18:58.415881+00:00',false),
  ('447c7e75-4340-4231-b92a-0d59542d40f3','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Relevé de jambes',NULL,'{}','2026-04-26T10:36:45.552117+00:00',false),
  ('a840d559-bb7d-4805-933a-6b16c275e556','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Relevés de jambes suspendu',NULL,'{}','2026-04-28T17:56:10.782711+00:00',false);

UPDATE session_exercises se
   SET exercise_id = v.ex, name = v.nom
  FROM (VALUES
    ('b3717637-1bc1-4436-afc2-e1030fc26835'::uuid,'dd03c50f-2ae3-4293-b6bc-5043410b0f16'::uuid,'Tirage horizontal unilatéral'),
    ('2ff2ed38-394a-4d31-8ce4-d8adff2a7321','59a47b29-168b-4181-b415-b33fa4a434ef','Rowing Matrix Neutre'),
    ('701aefc2-3263-4512-bf76-19dff050764e','447c7e75-4340-4231-b92a-0d59542d40f3','Relevé de jambes'),
    ('9d5714dc-64a2-4da4-9b3c-7d8c82bd701e','a840d559-bb7d-4805-933a-6b16c275e556','Relevés de jambes suspendu'),
    ('a5bac3c8-05da-4f0a-866c-5b786c1e2a39','a840d559-bb7d-4805-933a-6b16c275e556','Relevés de jambes suspendu'),
    ('3c926848-7239-4f46-8c8a-3d13a2f07d0b','a840d559-bb7d-4805-933a-6b16c275e556','Relevés de jambes suspendu'),
    ('02c613be-2e3d-4f3c-a06b-75c0327550aa','a840d559-bb7d-4805-933a-6b16c275e556','Relevés de jambes suspendu'),
    ('6cef9250-aa22-453a-a920-105608d00120','a840d559-bb7d-4805-933a-6b16c275e556','Relevés de jambes suspendu'),
    ('462b8272-4fb3-4655-b881-604eef296ecf','a840d559-bb7d-4805-933a-6b16c275e556','Relevés de jambes suspendu'),
    ('f4caff97-a00b-492f-b298-75023e82414c','a840d559-bb7d-4805-933a-6b16c275e556','Relevés de jambes suspendu'),
    ('cf6a35a6-553b-4ea0-9d52-6d65d6bd2776','a840d559-bb7d-4805-933a-6b16c275e556','Relevés de jambes suspendu'),
    ('fb5df7da-b46f-4975-a687-98af8fbedcaf','a840d559-bb7d-4805-933a-6b16c275e556','Relevés de jambes suspendu'),
    ('63d7b76c-7479-4a26-aa0d-dbe825ca417b','a840d559-bb7d-4805-933a-6b16c275e556','Relevés de jambes suspendu'),
    ('573b381c-3b90-49b3-84a6-d761cf825a60','a840d559-bb7d-4805-933a-6b16c275e556','Relevés de jambes suspendu'),
    ('418560b9-60bc-46ba-95d2-dcf1e22838ee','a840d559-bb7d-4805-933a-6b16c275e556','Relevés de jambes suspendu')
  ) AS v(id, ex, nom)
 WHERE se.id = v.id;

COMMIT;
