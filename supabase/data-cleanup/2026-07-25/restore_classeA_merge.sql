-- Sauvegarde avant fusion « classe A » — projet vbdyzcedymuafiozklze
-- Compte : cd.deleuse@gmail.com (60e7d781-5aee-402f-bb4f-298f6eb16fd8)
--
-- Fusions appliquées (gagnant <- perdants) :
--   Dips machine                            <- Machine dips, Machine Dips
--   Spider Curl                             <- Spider curl, Spiderman Curl
--   Pec deck                                <- Pecdeck
--   Skull crusher haltères sur banc incliné <- Skullcrusher haltères incliné
--
-- Pour annuler : exécuter ce fichier tel quel. Il recrée les 6 lignes
-- `exercises` avec leurs id d'origine, puis rend à chacune des 17 lignes
-- `session_exercises` son exercise_id et son name d'avant.

BEGIN;

INSERT INTO exercises (id, user_id, name, category, muscle_groups, created_at, is_certified) VALUES
  ('0bddb873-dbbe-4d31-82c0-619d2314d976','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Machine dips',NULL,'{}','2026-03-26T20:40:09.464222+00:00',false),
  ('96ee3f51-9be1-4eb0-9bee-645e8b754450','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Machine Dips',NULL,'{}','2026-04-05T08:49:55.680857+00:00',false),
  ('1ce18ef7-dc30-4005-8858-062772eaec81','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Spider curl',NULL,'{}','2026-03-26T20:40:09.464222+00:00',false),
  ('d9bd0e0f-9614-4a1f-ab43-07857d5f81f0','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Spiderman Curl',NULL,'{}','2026-04-19T06:56:40.308959+00:00',false),
  ('35c0df43-bd5b-4202-9523-072e4f7a697b','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Pecdeck',NULL,'{}','2026-06-12T20:07:03.422834+00:00',false),
  ('bfb77b38-f370-4dfb-81c7-fbfd514994b1','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Skullcrusher haltères incliné',NULL,'{}','2026-04-23T05:14:13.141559+00:00',false);

UPDATE session_exercises se
   SET exercise_id = v.exercise_id, name = v.name
  FROM (VALUES
    ('31145030-adc8-436b-9884-b8c05fc0e9cc'::uuid,'0bddb873-dbbe-4d31-82c0-619d2314d976'::uuid,'Machine dips'),
    ('3767d81e-cdb1-480a-a490-3db8cd11c881','0bddb873-dbbe-4d31-82c0-619d2314d976','Machine dips'),
    ('3728b35b-c67f-4e44-9468-e1dee60d00d9','0bddb873-dbbe-4d31-82c0-619d2314d976','Machine dips'),
    ('b610664f-82c6-4a59-9045-7131286e3b84','96ee3f51-9be1-4eb0-9bee-645e8b754450','Machine Dips'),
    ('8f5cc7e9-f4e9-404a-9e25-158042a6a8b7','1ce18ef7-dc30-4005-8858-062772eaec81','Spider curl'),
    ('da3dd854-146f-4bfa-8fac-dccf71a17e51','1ce18ef7-dc30-4005-8858-062772eaec81','Spider curl'),
    ('afee8c0a-ce5e-40e2-9aa8-8c486df796fa','1ce18ef7-dc30-4005-8858-062772eaec81','Spider curl'),
    ('af01af56-bc39-40b2-bf93-22f19c314fc1','d9bd0e0f-9614-4a1f-ab43-07857d5f81f0','Spiderman Curl'),
    ('b6d8c95d-6aa1-4a26-b476-c638493f7ed1','35c0df43-bd5b-4202-9523-072e4f7a697b','Pecdeck'),
    ('e7de955e-79a6-4f64-8171-3e369edbc455','bfb77b38-f370-4dfb-81c7-fbfd514994b1','Skullcrusher haltères incliné'),
    ('fd7095e0-d4e1-4a25-a770-34713b5ef9e2','bfb77b38-f370-4dfb-81c7-fbfd514994b1','Skullcrusher haltères incliné'),
    ('1236e855-dc79-4f41-982f-1df74299e1f0','bfb77b38-f370-4dfb-81c7-fbfd514994b1','Skullcrusher haltères incliné'),
    ('3dbfa3bc-4655-46dd-b54a-ca8a7d9c8900','bfb77b38-f370-4dfb-81c7-fbfd514994b1','Skullcrusher haltères incliné'),
    ('8e05a1fd-6b35-459b-bfe2-270929067792','bfb77b38-f370-4dfb-81c7-fbfd514994b1','Skullcrusher haltères incliné'),
    ('e2524047-9f67-4f31-a741-ffe65fa27129','bfb77b38-f370-4dfb-81c7-fbfd514994b1','Skullcrusher haltères incliné'),
    ('ee54f820-a293-46e6-98a7-3263a536bc2b','bfb77b38-f370-4dfb-81c7-fbfd514994b1','Skullcrusher haltères incliné'),
    ('2219a453-3a3f-4306-86e0-1fecad498001','bfb77b38-f370-4dfb-81c7-fbfd514994b1','Skullcrusher haltères incliné')
  ) AS v(id, exercise_id, name)
 WHERE se.id = v.id;

COMMIT;
