-- Sauvegarde avant nettoyage des noms d'exercices — projet vbdyzcedymuafiozklze
--
-- 1) Espaces : 36 lignes `exercises` + 75 lignes `session_exercises` avaient un
--    espace final (saisie PWA sans trim), toutes sur le compte
--    axelejan@gmail.com (eac1b79d-116d-4efd-8cfc-0206001206dc). Vérifié :
--    l'écart était EXACTEMENT un espace final dans les 111 cas, jamais un
--    double espace interne — d'où la restauration par concaténation ci-dessous,
--    exacte et non approximative.
--
-- 2) Casse : 3 exos du compte cd.deleuse@gmail.com remis dans leur casse
--    d'origine (Title Case), par id.
--
-- Pour annuler : exécuter ce fichier tel quel.

BEGIN;

-- 1) Réintroduit l'espace final sur les seuls noms qui l'avaient.
UPDATE exercises SET name = name || ' '
 WHERE user_id = 'eac1b79d-116d-4efd-8cfc-0206001206dc'
   AND id IN (
  '38c39dc4-fd30-4805-b751-8d6cddb5b62e','47aedd22-48b4-40d8-a1e6-494d5e5ce99b',
  '9c840e89-7b1b-40cc-8661-188cc5755717','8d4fb2de-6160-45df-8f36-092ec57f4f9d',
  '365ce692-1183-4080-baaf-6d268685535b','e9d35a58-3be9-48d6-9dee-4091e87d7213',
  '1e751767-a8aa-4638-a833-685252df2b56','3d54490d-b6cf-4258-ad11-43ee1d6b994c',
  '7564e939-c07c-4e0c-959f-308c43e36cf9','6afdec71-ee45-47d7-853b-f06d67ac02cd',
  '95b920ee-a2ef-4b93-8d93-c3d111ecb8e6','2b4223da-d29e-4187-bfc6-5a1fd7e883c8',
  '8c4e9a9c-e072-4e0f-b283-2081691d07f2','0a277384-d196-4e0d-9a62-9f8c7702fbf6',
  'c2b8681a-97d5-4177-a13a-90c3d99c4a9c','9487569b-c7d4-4916-9432-98b23a2c0a9d',
  '7a75ab35-e4ef-4a63-98d1-b43767972964','5911af6b-b1c0-4fb9-a383-ee2427baa3a8',
  'df9bdc22-fe12-46a3-9dbc-50228ac98dfc','cec531fb-8146-4be2-9c56-31f06d61b64e',
  '96390116-38ca-4b81-afe8-9bcdabe19b07','16d55eb0-a97e-4790-a81c-417cd6749fd4',
  '064cc154-958d-425c-94b8-2f60ed6188ac','8e9804f2-308f-44f0-b143-257853427bbb',
  'cb5d81d2-6861-4d37-ade2-0f6c3bd42854','a3588885-37f9-47a1-af9b-e47729fd7034',
  'a60647fa-d9ad-484a-b728-10a2d2bfcf09','1b1720f4-2e71-4e4a-9672-d4b715ebbaeb',
  '7875f8f8-101d-4c03-ba43-a9ede93fa7b5','cc438db1-6668-4e3b-a078-55ee3f92b544',
  '629248cd-2e90-4088-903e-6392842f0ff1','8b447b59-1b64-4207-8793-3bd90890501c',
  '70ddfe90-881a-4bf5-b464-1a005f4ab3eb','8003c0d2-f312-448b-9154-734c3b9be157',
  '44d6168a-5cfa-438b-90a9-a1c3ec0a596e','21c60b1a-512a-4572-a43f-8a4a091bb9a2');

UPDATE session_exercises SET name = name || ' '
 WHERE id IN (
  'e600c1de-2d52-4d08-8083-3200975d3827','d6b5df03-108a-4b9a-bbfc-83f5cb1cb687',
  'ad526250-58d1-48fd-b611-14f89b8bf327','abf812e1-b5a7-470f-b91e-241eb518f077',
  '49388050-85ff-48ed-ab0a-b96cad0624f1','745d38a4-53cc-455e-b37d-ea740e5eab68',
  'c4ca5ddf-4571-4dd2-b8be-0a17ee96c79a','d96e5d01-8205-4440-9e1a-a0658890b25a',
  'dc43da99-02fb-4f66-b88d-83a2dffcb088','9a63c6e8-1fdd-46f4-9317-1dbb9623a4bb',
  '25a65638-9f66-4ca9-8300-43cd70feaa48','e068ba5b-1de9-4720-ac32-e8d86c32a348',
  'c2a76f19-6eae-4990-bac1-b66311f6fee9','acbcde9e-8953-4204-833e-21e79d75b2d0',
  '94a654f8-7b4f-4564-b3bf-f7c56559c623','bf55ac6d-cfe6-40f2-9d07-3bfb8f3e31ee',
  '79109c85-a18a-41b6-9122-68e0e00066a6','4d32295b-9cea-45d1-a08c-916dfba2b5ee',
  '8a54261d-ce0a-4067-beef-23c1e9074510','180b2b9d-6a29-41a9-931b-b0915303a006',
  '437ec782-c4f3-4b74-b1bc-2bab5e020df9','0f0e9981-fce6-453c-8967-82dff444da7b',
  '074ad819-f0de-4645-b6b0-f36e355f2811','36fec22a-425d-4064-9688-1c0c2d96ab7e',
  '7ad56d63-3e91-404f-917f-b532c94bdc51','c0c2ba13-6d79-4305-b252-9fa20233bdad',
  '0678c97e-c65d-483f-9ce5-e273f5156705','bc951d23-950f-4b9c-95e4-8e966cf272ad',
  'f96fc4d8-da8e-4f58-b4a6-f4c966119361','2ffbc957-180d-4995-b627-f0d84f3b5e8c',
  '47b1d59c-ac19-491d-8468-5d4b34309c93','57d7cd84-4ec8-4079-8f9d-50493d3a0def',
  'c4bebb01-15f2-40b9-99c8-0989490d16fa','c422c338-a0de-4a52-9e0d-ba11068016f1',
  '3fbba0a3-83dd-46d8-b2b6-f1e962644655','ea884705-7ba4-40c6-8b47-02db3e4fd41e',
  '85882853-c54a-43e7-b109-7265d0cdb339','765b3227-24a5-46b8-91f0-93beca516cfa',
  '82b189e6-d4b2-40be-8ed6-3b40238a89d5','2b2c12f3-994b-4088-8cbb-7f4d8af8ec88',
  '3a536ddb-dfee-4c3e-84a6-96e39959ed27','10f748ab-c061-4eda-8352-989641e53d66',
  '7ab6ce38-4152-4aa4-aa04-5ef6e8258850','bba3329d-95f9-401c-a6cc-dbc0e5923ecc',
  '1ca52f39-7cd7-4b02-9004-ae5595964e16','4450405b-f581-4d1f-9d67-e2869b272763',
  'ed3d59ed-58c5-43fd-8899-7611ebaa0f46','398f1e61-8df8-4776-af45-31f4c274dcb0',
  '14c800d6-5e2c-484a-b5bd-0d9e6a4c5b86','334f49b9-cc25-46a6-9bb9-287fc9d0f368',
  'b75fa59f-630b-497d-8591-e8b9d22448f4','78571c28-5b53-4c0a-8ebe-f5793b3e4ce1',
  '68188518-fba9-492f-a909-41160b726e4c','e593701c-ba20-43c4-8f30-f4f08c554ced',
  '820fb861-8f52-404b-9cf8-ee450c301c35','e087d6cf-ee47-488e-9e08-4dff663baea0',
  '059d40d8-7901-4174-b3c5-70308bb3f8da','a77ff99b-bbe7-4969-a55e-dcf42e0d8ccb',
  '8458b19d-a149-4e18-bb01-2aaf48342b69','675ce49d-6290-456a-b86d-d6e38991c65a',
  'b1892ea6-753e-4104-80c0-27752196ce8d','efc61c3a-1363-46d5-a190-009cbae3ed13',
  'eba8e0a5-c8b7-454e-a0d3-325e0b7233d4','c2457f9c-389f-4577-9ba1-2e1002219222',
  '6ac5a79c-fd6c-4855-98f4-807d5b659bc6','76860462-a479-45b6-bc48-93cf241e02b0',
  '1e0fb0ff-3b5e-4ac9-b319-a2998e318e00','ee6e8e6e-5cb3-42dd-b565-c891f64f3523',
  'e83d5c28-c519-4b94-afbd-e48f63b1b878','2291ee8d-3ed0-431d-bff5-bcd47985f809',
  '8db63f1d-fdd7-405e-aa51-1a16bc101840','82e33e21-0a14-40fb-ab06-c162c97fc3b7',
  '01071cb8-724b-4ef1-9fcf-b9af5b223c55','c84315ab-8177-49df-ad0a-9be43099353b',
  '52de9097-9837-45d9-b1ce-67acdff04fa9');

-- 2) Casse d'origine (compte cd.deleuse), exos + snapshots d'historique.
UPDATE exercises SET name = v.n FROM (VALUES
    ('6fa7be66-4aa5-4f47-8b17-f9f4f434df1c'::uuid,'Chest Press'),
    ('df4bd122-ecd5-496e-a8ed-07c8dc42efd3','Rear Delt'),
    ('5de5883d-5f46-48ee-b8f9-13fbf7e556dc','Spider Curl')
  ) AS v(id, n) WHERE exercises.id = v.id;

UPDATE session_exercises se SET name = v.n FROM (VALUES
    ('6fa7be66-4aa5-4f47-8b17-f9f4f434df1c'::uuid,'Chest Press'),
    ('df4bd122-ecd5-496e-a8ed-07c8dc42efd3','Rear Delt'),
    ('5de5883d-5f46-48ee-b8f9-13fbf7e556dc','Spider Curl')
  ) AS v(id, n) WHERE se.exercise_id = v.id;

COMMIT;
