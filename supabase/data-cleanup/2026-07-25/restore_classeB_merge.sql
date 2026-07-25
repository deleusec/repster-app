-- Sauvegarde avant fusion « classe B » (partie sans template)
-- Projet vbdyzcedymuafiozklze — compte cd.deleuse@gmail.com
--
-- Fusions : exo perso -> exo CERTIFIÉ (l'id certifié devient l'exercise_id).
-- Le `name` snapshoté dans session_exercises n'est PAS touché : c'est le nom
-- localisé que l'utilisateur voit et que les futures séances écriront.
--
--   Tirage vertical   -> Lat Pulldown    (f1455990-b6e9-4554-a2ff-388adf7ac235)
--   Rowing barre      -> Barbell Row     (42926f56-9d66-4e02-8d7f-51fb69e3b9d2)
--   Fentes marchées   -> Lunge           (2d12a80f-e8d8-4587-abfb-a804c302c034)
--   Dips              -> Dip             (e79e2664-9fbe-4d4c-a56d-47da5d2bcb59)
--   Leg press         -> Leg Press       (002c7dd7-9a04-49ad-896b-ee506994a27b)
--   Pec Fly           -> Dumbbell Fly    (db6bb85d-440a-4dff-a39e-48353063bd45)
--   Skull Crusher     -> Skull Crusher   (1c90714c-309a-4d6b-aa77-c0eca361e124)
--
-- Pour annuler : exécuter ce fichier tel quel. Il recrée les 7 lignes perso avec
-- leurs id d'origine, puis rend son exercise_id à chaque ligne d'historique en
-- se basant sur le `name` snapshoté (jamais modifié, donc fiable comme clé).

BEGIN;

INSERT INTO exercises (id, user_id, name, category, muscle_groups, created_at, is_certified) VALUES
  ('631a32e4-25a3-4ea7-aabf-d85a2e6f11cd','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Tirage vertical',NULL,'{}','2026-03-26T20:39:22.172754+00:00',false),
  ('9897c1c5-f2ce-4d73-976b-a035385a2dac','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Rowing barre',NULL,'{}','2026-04-28T18:40:00.532334+00:00',false),
  ('e598884d-a0be-4575-9e41-0c9002821a85','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Fentes marchées',NULL,'{}','2026-03-26T20:41:30.006021+00:00',false),
  ('aa3b7544-e38d-443e-ad3d-5b01d7dd9cf9','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Dips',NULL,'{}','2026-03-26T20:39:22.172754+00:00',false),
  ('aeca3c4b-8462-4244-b963-d33ecbe5c389','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Leg press',NULL,'{}','2026-03-26T20:41:30.006021+00:00',false),
  ('77f27ed3-1e08-477f-8fe6-6c09bf5b2d4e','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Pec Fly',NULL,'{}','2026-05-17T07:27:49.286924+00:00',false),
  ('fd9ee1a1-8bfd-428c-8fdc-b6b303bb4204','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Skull Crusher',NULL,'{}','2026-04-26T10:36:45.552117+00:00',false);

UPDATE session_exercises se
   SET exercise_id = v.perso
  FROM (VALUES
    ('Tirage vertical','631a32e4-25a3-4ea7-aabf-d85a2e6f11cd'::uuid,'f1455990-b6e9-4554-a2ff-388adf7ac235'::uuid),
    ('Rowing barre',   '9897c1c5-f2ce-4d73-976b-a035385a2dac','42926f56-9d66-4e02-8d7f-51fb69e3b9d2'),
    ('Fentes marchées','e598884d-a0be-4575-9e41-0c9002821a85','2d12a80f-e8d8-4587-abfb-a804c302c034'),
    ('Dips',           'aa3b7544-e38d-443e-ad3d-5b01d7dd9cf9','e79e2664-9fbe-4d4c-a56d-47da5d2bcb59'),
    ('Leg press',      'aeca3c4b-8462-4244-b963-d33ecbe5c389','002c7dd7-9a04-49ad-896b-ee506994a27b'),
    ('Pec Fly',        '77f27ed3-1e08-477f-8fe6-6c09bf5b2d4e','db6bb85d-440a-4dff-a39e-48353063bd45'),
    ('Skull Crusher',  'fd9ee1a1-8bfd-428c-8fdc-b6b303bb4204','1c90714c-309a-4d6b-aa77-c0eca361e124')
  ) AS v(nom, perso, certifie)
 WHERE se.name = v.nom AND se.exercise_id = v.certifie;

COMMIT;
