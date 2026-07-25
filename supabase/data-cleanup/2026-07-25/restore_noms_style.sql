-- Sauvegarde avant les 5 renommages de style — projet vbdyzcedymuafiozklze
-- Compte cd.deleuse@gmail.com (60e7d781-5aee-402f-bb4f-298f6eb16fd8)
--
--   Incline bench pushdown         -> Extension triceps pushdown banc incliné
--   Mollets debout ou presse       -> Mollets debout
--   Écartés haltères               -> Écarté haltères
--   Élévations latérales haltères  -> Élévation latérale haltères
--   Extension triceps unilatérales -> Extension triceps unilatérale
--
-- `exercises.name` ET `session_exercises.name` sont réécrits ensemble : le nom
-- est snapshoté dans l'historique et fetchExerciseHistory matche dessus.
--
-- Pour annuler : exécuter ce fichier tel quel.

BEGIN;

UPDATE exercises SET name = v.avant FROM (VALUES
    ('08d4fe25-010c-455c-ae4d-87d227395012'::uuid,'Incline bench pushdown'),
    ('0cfe03ed-ac28-4a8a-a68f-802bd87ac4fe','Mollets debout ou presse'),
    ('e863b4ba-0cdc-445c-b305-0f5f8ac36d4f','Écartés haltères'),
    ('15f62e27-afcb-4d46-8eb5-5b4f75d96707','Élévations latérales haltères'),
    ('ebecda06-e41d-4515-b2d6-1b5fcc0c66e2','Extension triceps unilatérales')
  ) AS v(id, avant) WHERE exercises.id = v.id;

UPDATE session_exercises se SET name = v.avant FROM (VALUES
    ('08d4fe25-010c-455c-ae4d-87d227395012'::uuid,'Incline bench pushdown'),
    ('0cfe03ed-ac28-4a8a-a68f-802bd87ac4fe','Mollets debout ou presse'),
    ('e863b4ba-0cdc-445c-b305-0f5f8ac36d4f','Écartés haltères'),
    ('15f62e27-afcb-4d46-8eb5-5b4f75d96707','Élévations latérales haltères'),
    ('ebecda06-e41d-4515-b2d6-1b5fcc0c66e2','Extension triceps unilatérales')
  ) AS v(id, avant) WHERE se.exercise_id = v.id;

COMMIT;
