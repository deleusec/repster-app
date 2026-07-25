-- Sauvegarde avant fusion « classe B » — 2e partie (les 7 exos référencés par un template)
-- Projet vbdyzcedymuafiozklze — compte cd.deleuse@gmail.com
--
--   Face pull                     -> Face Pull            (f1690ab6-c6e6-431d-9b31-d8768e6022d7)
--   Leg curl                      -> Leg Curl             (ebe59df9-ae9b-4ad0-b458-ffc99dde7a6e)
--   Leg extension                 -> Leg Extension        (4307a94a-810d-4a69-bf7b-dca1846c7feb)
--   Développé couché              -> Barbell Bench Press  (db565969-5101-46e4-86be-83e5a7979a8e)
--   Développé couché prise serrée -> Close-Grip Bench Press (96af0def-1b91-41d9-917f-58a721880b1d)
--   Romanian deadlift             -> Romanian Deadlift    (98b36299-af93-4f44-a81b-cb2636604663)
--   Tirage horizontal             -> Seated Cable Row     (29ebf8b2-2684-47a6-9e5b-2eb82ea40ba9)
--
-- Deux exos ont AUSSI eu leur `name` d'historique réécrit vers le nom FR du
-- catalogue (sinon fetchExerciseHistory, qui matche sur le nom, se scinderait) :
--   Romanian deadlift -> Soulevé de terre roumain
--   Tirage horizontal -> Rowing assis à la poulie
-- Les 5 autres ont un nom FR identique à l'ancien : rien réécrit.
--
-- Pour annuler : exécuter ce fichier tel quel.

BEGIN;

INSERT INTO exercises (id, user_id, name, category, muscle_groups, created_at, is_certified) VALUES
  ('e07619ed-7ceb-445c-b485-3ccd2c461991','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Face pull',NULL,'{}','2026-03-26T20:39:22.172754+00:00',false),
  ('60c20a3d-b303-431e-989d-2fe24eb711b4','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Leg curl',NULL,'{}','2026-03-26T20:41:30.006021+00:00',false),
  ('e817f45a-0724-4813-bee8-99ca84b59b2d','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Leg extension',NULL,'{}','2026-03-26T20:41:30.006021+00:00',false),
  ('207df75c-be3d-415a-85c9-538a6a17c68a','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Développé couché',NULL,'{}','2026-03-26T16:56:52.33247+00:00',false),
  ('4a36c8e3-35bf-4bf6-b7d7-8d447c509822','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Développé couché prise serrée',NULL,'{}','2026-03-26T20:45:05.591159+00:00',false),
  ('c35a951a-b946-4c80-8c82-8e0553dccdf1','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Romanian deadlift',NULL,'{}','2026-03-26T20:41:30.006021+00:00',false),
  ('14957dae-e451-4e88-947f-e3159dabebea','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Tirage horizontal',NULL,'{}','2026-05-15T20:12:59.448278+00:00',false);

-- Templates : repointer vers l'exo perso. Le critère est la cible certifiée —
-- sans ambiguïté, car aucun template ne pointait un certifié avant la fusion.
-- (Lignes concernées, pour mémoire : 7de760ed, 1ee6665e, 6708ed59, 36cd912d,
--  aacff8c0, 42944eaa, b9008b47, 983b9018, c1a11ac5, 9a751246.)
UPDATE template_exercises te SET exercise_id = m.perso
  FROM (VALUES
    ('f1690ab6-c6e6-431d-9b31-d8768e6022d7'::uuid,'e07619ed-7ceb-445c-b485-3ccd2c461991'::uuid),
    ('ebe59df9-ae9b-4ad0-b458-ffc99dde7a6e','60c20a3d-b303-431e-989d-2fe24eb711b4'),
    ('4307a94a-810d-4a69-bf7b-dca1846c7feb','e817f45a-0724-4813-bee8-99ca84b59b2d'),
    ('db565969-5101-46e4-86be-83e5a7979a8e','207df75c-be3d-415a-85c9-538a6a17c68a'),
    ('96af0def-1b91-41d9-917f-58a721880b1d','4a36c8e3-35bf-4bf6-b7d7-8d447c509822'),
    ('98b36299-af93-4f44-a81b-cb2636604663','c35a951a-b946-4c80-8c82-8e0553dccdf1'),
    ('29ebf8b2-2684-47a6-9e5b-2eb82ea40ba9','14957dae-e451-4e88-947f-e3159dabebea')
  ) AS m(certifie, perso)
 WHERE te.exercise_id = m.certifie;

-- Historique : rendre l'exercise_id ET le nom d'origine
UPDATE session_exercises se SET exercise_id = m.perso, name = m.nom_avant
  FROM (VALUES
    ('f1690ab6-c6e6-431d-9b31-d8768e6022d7'::uuid,'e07619ed-7ceb-445c-b485-3ccd2c461991'::uuid,'Face pull'),
    ('ebe59df9-ae9b-4ad0-b458-ffc99dde7a6e','60c20a3d-b303-431e-989d-2fe24eb711b4','Leg curl'),
    ('4307a94a-810d-4a69-bf7b-dca1846c7feb','e817f45a-0724-4813-bee8-99ca84b59b2d','Leg extension'),
    ('db565969-5101-46e4-86be-83e5a7979a8e','207df75c-be3d-415a-85c9-538a6a17c68a','Développé couché'),
    ('96af0def-1b91-41d9-917f-58a721880b1d','4a36c8e3-35bf-4bf6-b7d7-8d447c509822','Développé couché prise serrée'),
    ('98b36299-af93-4f44-a81b-cb2636604663','c35a951a-b946-4c80-8c82-8e0553dccdf1','Romanian deadlift'),
    ('29ebf8b2-2684-47a6-9e5b-2eb82ea40ba9','14957dae-e451-4e88-947f-e3159dabebea','Tirage horizontal')
  ) AS m(certifie, perso, nom_avant)
 WHERE se.exercise_id = m.certifie;

COMMIT;
