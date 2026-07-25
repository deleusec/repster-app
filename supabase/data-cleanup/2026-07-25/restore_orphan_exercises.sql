-- Sauvegarde avant suppression des 20 exercices orphelins
-- Projet Supabase : vbdyzcedymuafiozklze
-- Critère de suppression : NOT is_certified
--                          AND aucune ligne template_exercises
--                          AND aucune ligne session_exercises
-- Aucune de ces lignes n'avait d'entrée exercise_names.
-- Pour annuler : exécuter ce fichier tel quel (les id d'origine sont conservés).

BEGIN;

INSERT INTO exercises (id, user_id, name, category, muscle_groups, created_at, is_certified) VALUES
  ('56d6429e-db85-43f9-a543-3039cc222b60','eac1b79d-116d-4efd-8cfc-0206001206dc','Oiseaux poulie  unilatéral',NULL,'{}','2026-04-02T16:04:37.605267+00:00',false),
  ('bb7a34fa-b02b-4f70-b270-26abba293e2a','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Développé couché décliné',NULL,'{}','2026-05-15T20:12:59.448278+00:00',false),
  ('495f68d1-0cfb-4691-be47-da4f9a9269f0','eac1b79d-116d-4efd-8cfc-0206001206dc','Tirage verticale ',NULL,'{}','2026-04-01T06:52:49.098351+00:00',false),
  ('6c90126c-16a2-4194-b825-5a00c204bd5f','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Extension triceps unilatérale poulie',NULL,'{}','2026-05-15T20:12:59.448278+00:00',false),
  ('fdcfa8f3-2ccd-4504-a598-009b602ca945','4ad86a2e-8c62-48a8-9e28-278d0bb38962','Extension triceps unilatérale poulie',NULL,'{}','2026-05-17T07:31:21.489504+00:00',false),
  ('b7684ac8-c68c-4fc4-9cae-8e8cc0d92b02','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Écarté poulie basse → haute',NULL,'{}','2026-06-12T19:45:55.136601+00:00',false),
  ('75c3b59c-b789-418c-b0b7-be1d06523bc2','eac1b79d-116d-4efd-8cfc-0206001206dc','Tirage horizontal ',NULL,'{}','2026-04-01T06:52:49.098351+00:00',false),
  ('af24eccf-69c2-42a7-a14e-5624bd40cff7','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Dev couch ',NULL,'{}','2026-03-28T22:51:54.98599+00:00',false),
  ('cd1ca6eb-f117-48ad-8bd1-4883aa3a32b9','eac1b79d-116d-4efd-8cfc-0206001206dc','Dois machine ',NULL,'{}','2026-03-31T14:53:44.686261+00:00',false),
  ('8577877e-5282-4e45-8cec-419db707b3a1','eac1b79d-116d-4efd-8cfc-0206001206dc','Triceps poulie ',NULL,'{}','2026-03-31T14:53:44.686261+00:00',false),
  ('c9ade2d5-d19e-4d7a-8072-7b17810e78e0','4ad86a2e-8c62-48a8-9e28-278d0bb38962','Tirage horizontal unilatéral poulie',NULL,'{}','2026-05-17T07:31:21.489504+00:00',false),
  ('d43acb6e-e7ea-4e0c-99af-66879e581836','eac1b79d-116d-4efd-8cfc-0206001206dc','Curl poulie',NULL,'{}','2026-05-05T09:32:50.405808+00:00',false),
  ('f8b27ce8-a78b-41ea-a72a-45195958109d','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Écarté haltères',NULL,'{}','2026-03-26T16:56:52.33247+00:00',false),
  ('548614ed-017a-4a44-8473-00c0a0f97494','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Test',NULL,'{}','2026-05-15T20:08:40.744391+00:00',false),
  ('d4e03f41-b5e8-4dd2-8544-571bca5983c2','eac1b79d-116d-4efd-8cfc-0206001206dc','Pull over ',NULL,'{}','2026-04-01T06:52:49.098351+00:00',false),
  ('f63f98fe-b097-4e89-8361-2bc6a8b101e7','4ad86a2e-8c62-48a8-9e28-278d0bb38962','Écarté poulie vis-à-vis poulies hautes',NULL,'{}','2026-05-17T07:31:21.489504+00:00',false),
  ('686d3a3d-22bd-4fe5-b9d5-ae0f0eb93dce','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Curl marteau',NULL,'{}','2026-04-23T05:14:13.141559+00:00',false),
  ('4cc168ba-ba64-43b6-90a6-2bf2c18ff4b9','eac1b79d-116d-4efd-8cfc-0206001206dc','Dev smtih ',NULL,'{}','2026-03-31T14:53:44.686261+00:00',false),
  ('3aa1149a-34a4-414b-8b3f-5414f661b817','60e7d781-5aee-402f-bb4f-298f6eb16fd8','Position caca dans la forêt ',NULL,'{}','2026-03-28T22:51:54.98599+00:00',false),
  ('b1eaba84-815f-4730-a633-12f710bcb801','eac1b79d-116d-4efd-8cfc-0206001206dc','Oiseaux poulie ',NULL,'{}','2026-04-01T06:52:49.098351+00:00',false);

COMMIT;
