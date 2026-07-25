-- ============================================================
-- Repster — Certified exercise catalog seed (batch 1)
-- ------------------------------------------------------------
-- ~48 classic exercises across every muscle group. Each has an English
-- canonical name, a primary display name per locale (en/fr/es/de/it) and
-- searchable aliases/variants (locale-scoped, or language-agnostic when
-- locale is null, e.g. "OHP", "RDL"). Idempotent: re-running upserts by
-- lower(name) and skips duplicate names. Runs with elevated privileges
-- (migration), so RLS does not block writing certified rows.
-- ============================================================

DO $do$
DECLARE
  rec    jsonb;
  nm     jsonb;
  ex_id  uuid;
BEGIN
  FOR rec IN
    SELECT value FROM jsonb_array_elements($j$
[
  {"name":"Barbell Bench Press","category":"compound","muscles":["chest","triceps","shoulders"],"names":[
    {"locale":"en","name":"Barbell Bench Press","primary":true},{"locale":"en","name":"Bench Press"},{"locale":"en","name":"Flat Bench Press"},
    {"locale":"fr","name":"Développé couché","primary":true},{"locale":"fr","name":"Développé couché barre"},{"locale":"fr","name":"DC"},
    {"locale":"es","name":"Press de banca","primary":true},{"locale":"es","name":"Press banca"},
    {"locale":"de","name":"Bankdrücken","primary":true},{"locale":"de","name":"Langhantel-Bankdrücken"},
    {"locale":"it","name":"Panca piana","primary":true},{"locale":"it","name":"Distensioni su panca piana"},
    {"locale":null,"name":"BP"}]},

  {"name":"Incline Barbell Bench Press","category":"compound","muscles":["chest","shoulders"],"names":[
    {"locale":"en","name":"Incline Bench Press","primary":true},{"locale":"en","name":"Incline Barbell Press"},
    {"locale":"fr","name":"Développé incliné","primary":true},{"locale":"fr","name":"DI"},
    {"locale":"es","name":"Press inclinado","primary":true},
    {"locale":"de","name":"Schrägbankdrücken","primary":true},
    {"locale":"it","name":"Panca inclinata","primary":true}]},

  {"name":"Dumbbell Bench Press","category":"compound","muscles":["chest","triceps"],"names":[
    {"locale":"en","name":"Dumbbell Bench Press","primary":true},{"locale":"en","name":"DB Bench Press"},
    {"locale":"fr","name":"Développé couché haltères","primary":true},
    {"locale":"es","name":"Press de banca con mancuernas","primary":true},
    {"locale":"de","name":"Kurzhantel-Bankdrücken","primary":true},
    {"locale":"it","name":"Distensioni con manubri su panca","primary":true}]},

  {"name":"Dumbbell Fly","category":"isolation","muscles":["chest"],"names":[
    {"locale":"en","name":"Dumbbell Fly","primary":true},{"locale":"en","name":"Chest Fly"},{"locale":"en","name":"Pec Fly"},
    {"locale":"fr","name":"Écarté haltères","primary":true},{"locale":"fr","name":"Écarté couché"},
    {"locale":"es","name":"Aperturas con mancuernas","primary":true},
    {"locale":"de","name":"Kurzhantel-Fliegende","primary":true},
    {"locale":"it","name":"Croci con manubri","primary":true}]},

  {"name":"Cable Crossover","category":"isolation","muscles":["chest"],"names":[
    {"locale":"en","name":"Cable Crossover","primary":true},{"locale":"en","name":"Cable Fly"},
    {"locale":"fr","name":"Écarté à la poulie","primary":true},{"locale":"fr","name":"Vis-à-vis"},
    {"locale":"es","name":"Cruce de poleas","primary":true},
    {"locale":"de","name":"Kabelzug-Fliegende","primary":true},
    {"locale":"it","name":"Croci ai cavi","primary":true}]},

  {"name":"Push-Up","category":"bodyweight","muscles":["chest","triceps"],"names":[
    {"locale":"en","name":"Push-Up","primary":true},{"locale":"en","name":"Press-Up"},
    {"locale":"fr","name":"Pompes","primary":true},
    {"locale":"es","name":"Flexiones","primary":true},
    {"locale":"de","name":"Liegestütze","primary":true},
    {"locale":"it","name":"Piegamenti","primary":true},{"locale":"it","name":"Flessioni"}]},

  {"name":"Dip","category":"compound","muscles":["chest","triceps"],"names":[
    {"locale":"en","name":"Dip","primary":true},{"locale":"en","name":"Chest Dip"},
    {"locale":"fr","name":"Dips","primary":true},
    {"locale":"es","name":"Fondos","primary":true},
    {"locale":"de","name":"Dips","primary":true},
    {"locale":"it","name":"Dip","primary":true},{"locale":"it","name":"Parallele"}]},

  {"name":"Deadlift","category":"compound","muscles":["back","hamstrings","glutes"],"names":[
    {"locale":"en","name":"Deadlift","primary":true},{"locale":"en","name":"Conventional Deadlift"},
    {"locale":"fr","name":"Soulevé de terre","primary":true},{"locale":"fr","name":"SDT"},
    {"locale":"es","name":"Peso muerto","primary":true},
    {"locale":"de","name":"Kreuzheben","primary":true},
    {"locale":"it","name":"Stacco da terra","primary":true},{"locale":"it","name":"Stacco"}]},

  {"name":"Pull-Up","category":"bodyweight","muscles":["back","biceps"],"names":[
    {"locale":"en","name":"Pull-Up","primary":true},
    {"locale":"fr","name":"Traction","primary":true},{"locale":"fr","name":"Traction pronation"},
    {"locale":"es","name":"Dominadas","primary":true},
    {"locale":"de","name":"Klimmzüge","primary":true},
    {"locale":"it","name":"Trazioni","primary":true},{"locale":"it","name":"Trazioni alla sbarra"}]},

  {"name":"Chin-Up","category":"bodyweight","muscles":["back","biceps"],"names":[
    {"locale":"en","name":"Chin-Up","primary":true},
    {"locale":"fr","name":"Traction supination","primary":true},
    {"locale":"es","name":"Dominadas supinas","primary":true},
    {"locale":"de","name":"Klimmzüge im Untergriff","primary":true},
    {"locale":"it","name":"Trazioni presa supina","primary":true}]},

  {"name":"Lat Pulldown","category":"compound","muscles":["back","biceps"],"names":[
    {"locale":"en","name":"Lat Pulldown","primary":true},{"locale":"en","name":"Pulldown"},
    {"locale":"fr","name":"Tirage vertical","primary":true},{"locale":"fr","name":"Tirage poitrine"},
    {"locale":"es","name":"Jalón al pecho","primary":true},{"locale":"es","name":"Jalón dorsal"},
    {"locale":"de","name":"Latzug","primary":true},
    {"locale":"it","name":"Lat machine","primary":true},{"locale":"it","name":"Tirata al petto"}]},

  {"name":"Barbell Row","category":"compound","muscles":["back","biceps"],"names":[
    {"locale":"en","name":"Barbell Row","primary":true},{"locale":"en","name":"Bent-Over Row"},{"locale":"en","name":"Bent Over Barbell Row"},
    {"locale":"fr","name":"Rowing barre","primary":true},{"locale":"fr","name":"Rowing buste penché"},
    {"locale":"es","name":"Remo con barra","primary":true},
    {"locale":"de","name":"Langhantelrudern","primary":true},
    {"locale":"it","name":"Rematore con bilanciere","primary":true},{"locale":"it","name":"Rematore"}]},

  {"name":"Dumbbell Row","category":"compound","muscles":["back","biceps"],"names":[
    {"locale":"en","name":"Dumbbell Row","primary":true},{"locale":"en","name":"One-Arm Dumbbell Row"},{"locale":"en","name":"DB Row"},
    {"locale":"fr","name":"Rowing haltère","primary":true},{"locale":"fr","name":"Rowing unilatéral"},
    {"locale":"es","name":"Remo con mancuerna","primary":true},
    {"locale":"de","name":"Kurzhantelrudern","primary":true},
    {"locale":"it","name":"Rematore con manubrio","primary":true}]},

  {"name":"Seated Cable Row","category":"compound","muscles":["back","biceps"],"names":[
    {"locale":"en","name":"Seated Cable Row","primary":true},{"locale":"en","name":"Cable Row"},
    {"locale":"fr","name":"Rowing assis à la poulie","primary":true},{"locale":"fr","name":"Tirage horizontal"},
    {"locale":"es","name":"Remo en polea sentado","primary":true},{"locale":"es","name":"Remo bajo"},
    {"locale":"de","name":"Rudern am Kabelzug","primary":true},
    {"locale":"it","name":"Rematore ai cavi","primary":true},{"locale":"it","name":"Pulley"}]},

  {"name":"T-Bar Row","category":"compound","muscles":["back"],"names":[
    {"locale":"en","name":"T-Bar Row","primary":true},
    {"locale":"fr","name":"Rowing T-bar","primary":true},{"locale":"fr","name":"Tirage T"},
    {"locale":"es","name":"Remo en T","primary":true},
    {"locale":"de","name":"T-Bar-Rudern","primary":true},
    {"locale":"it","name":"Rematore a T","primary":true}]},

  {"name":"Face Pull","category":"isolation","muscles":["shoulders","back"],"names":[
    {"locale":"en","name":"Face Pull","primary":true},
    {"locale":"fr","name":"Face pull","primary":true},{"locale":"fr","name":"Oiseau à la poulie"},
    {"locale":"es","name":"Face pull","primary":true},{"locale":"es","name":"Jalón a la cara"},
    {"locale":"de","name":"Face Pull","primary":true},
    {"locale":"it","name":"Face pull","primary":true}]},

  {"name":"Overhead Press","category":"compound","muscles":["shoulders","triceps"],"names":[
    {"locale":"en","name":"Overhead Press","primary":true},{"locale":"en","name":"Military Press"},{"locale":"en","name":"Shoulder Press"},{"locale":"en","name":"Standing Press"},
    {"locale":"fr","name":"Développé militaire","primary":true},{"locale":"fr","name":"Développé épaules debout"},
    {"locale":"es","name":"Press militar","primary":true},{"locale":"es","name":"Press de hombros"},
    {"locale":"de","name":"Schulterdrücken","primary":true},{"locale":"de","name":"Military Press"},
    {"locale":"it","name":"Lento avanti","primary":true},{"locale":"it","name":"Military press"},
    {"locale":null,"name":"OHP"}]},

  {"name":"Dumbbell Shoulder Press","category":"compound","muscles":["shoulders","triceps"],"names":[
    {"locale":"en","name":"Dumbbell Shoulder Press","primary":true},{"locale":"en","name":"Seated Dumbbell Press"},
    {"locale":"fr","name":"Développé épaules haltères","primary":true},
    {"locale":"es","name":"Press de hombros con mancuernas","primary":true},
    {"locale":"de","name":"Kurzhantel-Schulterdrücken","primary":true},
    {"locale":"it","name":"Distensioni sopra la testa con manubri","primary":true},{"locale":"it","name":"Shoulder press manubri"}]},

  {"name":"Lateral Raise","category":"isolation","muscles":["shoulders"],"names":[
    {"locale":"en","name":"Lateral Raise","primary":true},{"locale":"en","name":"Side Raise"},{"locale":"en","name":"Dumbbell Lateral Raise"},
    {"locale":"fr","name":"Élévations latérales","primary":true},{"locale":"fr","name":"Élévation latérale haltères"},
    {"locale":"es","name":"Elevaciones laterales","primary":true},
    {"locale":"de","name":"Seitheben","primary":true},
    {"locale":"it","name":"Alzate laterali","primary":true}]},

  {"name":"Front Raise","category":"isolation","muscles":["shoulders"],"names":[
    {"locale":"en","name":"Front Raise","primary":true},
    {"locale":"fr","name":"Élévations frontales","primary":true},
    {"locale":"es","name":"Elevaciones frontales","primary":true},
    {"locale":"de","name":"Frontheben","primary":true},
    {"locale":"it","name":"Alzate frontali","primary":true}]},

  {"name":"Rear Delt Fly","category":"isolation","muscles":["shoulders","back"],"names":[
    {"locale":"en","name":"Rear Delt Fly","primary":true},{"locale":"en","name":"Reverse Fly"},{"locale":"en","name":"Bent-Over Lateral Raise"},
    {"locale":"fr","name":"Oiseau","primary":true},{"locale":"fr","name":"Élévations postérieures"},
    {"locale":"es","name":"Pájaros","primary":true},{"locale":"es","name":"Aperturas posteriores"},
    {"locale":"de","name":"Reverse Flys","primary":true},{"locale":"de","name":"Vorgebeugtes Seitheben"},
    {"locale":"it","name":"Alzate posteriori","primary":true},{"locale":"it","name":"Croci inverse"}]},

  {"name":"Arnold Press","category":"compound","muscles":["shoulders","triceps"],"names":[
    {"locale":"en","name":"Arnold Press","primary":true},
    {"locale":"fr","name":"Développé Arnold","primary":true},
    {"locale":"es","name":"Press Arnold","primary":true},
    {"locale":"de","name":"Arnold-Press","primary":true},
    {"locale":"it","name":"Arnold press","primary":true}]},

  {"name":"Upright Row","category":"compound","muscles":["shoulders"],"names":[
    {"locale":"en","name":"Upright Row","primary":true},
    {"locale":"fr","name":"Tirage menton","primary":true},{"locale":"fr","name":"Rowing vertical"},
    {"locale":"es","name":"Remo al mentón","primary":true},{"locale":"es","name":"Remo vertical"},
    {"locale":"de","name":"Aufrechtes Rudern","primary":true},
    {"locale":"it","name":"Tirate al mento","primary":true}]},

  {"name":"Shrug","category":"isolation","muscles":["shoulders"],"names":[
    {"locale":"en","name":"Shrug","primary":true},{"locale":"en","name":"Barbell Shrug"},{"locale":"en","name":"Dumbbell Shrug"},
    {"locale":"fr","name":"Shrug","primary":true},{"locale":"fr","name":"Haussement d'épaules"},
    {"locale":"es","name":"Encogimientos","primary":true},
    {"locale":"de","name":"Schulterheben","primary":true},{"locale":"de","name":"Shrugs"},
    {"locale":"it","name":"Scrollate","primary":true}]},

  {"name":"Barbell Curl","category":"isolation","muscles":["biceps"],"names":[
    {"locale":"en","name":"Barbell Curl","primary":true},{"locale":"en","name":"Bicep Curl"},
    {"locale":"fr","name":"Curl barre","primary":true},{"locale":"fr","name":"Curl biceps barre"},
    {"locale":"es","name":"Curl con barra","primary":true},
    {"locale":"de","name":"Langhantel-Curls","primary":true},{"locale":"de","name":"Bizeps-Curls"},
    {"locale":"it","name":"Curl con bilanciere","primary":true}]},

  {"name":"Dumbbell Curl","category":"isolation","muscles":["biceps"],"names":[
    {"locale":"en","name":"Dumbbell Curl","primary":true},{"locale":"en","name":"Dumbbell Bicep Curl"},
    {"locale":"fr","name":"Curl haltères","primary":true},
    {"locale":"es","name":"Curl con mancuernas","primary":true},
    {"locale":"de","name":"Kurzhantel-Curls","primary":true},
    {"locale":"it","name":"Curl con manubri","primary":true}]},

  {"name":"Hammer Curl","category":"isolation","muscles":["biceps","forearms"],"names":[
    {"locale":"en","name":"Hammer Curl","primary":true},
    {"locale":"fr","name":"Curl marteau","primary":true},
    {"locale":"es","name":"Curl martillo","primary":true},
    {"locale":"de","name":"Hammercurls","primary":true},
    {"locale":"it","name":"Curl a martello","primary":true}]},

  {"name":"Preacher Curl","category":"isolation","muscles":["biceps"],"names":[
    {"locale":"en","name":"Preacher Curl","primary":true},
    {"locale":"fr","name":"Curl pupitre","primary":true},{"locale":"fr","name":"Curl au pupitre"},
    {"locale":"es","name":"Curl predicador","primary":true},{"locale":"es","name":"Curl en banco Scott"},
    {"locale":"de","name":"Scott-Curls","primary":true},{"locale":"de","name":"Preacher Curls"},
    {"locale":"it","name":"Curl su panca Scott","primary":true},{"locale":"it","name":"Panca Scott"}]},

  {"name":"Triceps Pushdown","category":"isolation","muscles":["triceps"],"names":[
    {"locale":"en","name":"Triceps Pushdown","primary":true},{"locale":"en","name":"Cable Pushdown"},{"locale":"en","name":"Tricep Pushdown"},
    {"locale":"fr","name":"Extension à la poulie","primary":true},{"locale":"fr","name":"Pushdown"},
    {"locale":"es","name":"Extensión de tríceps en polea","primary":true},{"locale":"es","name":"Jalón de tríceps"},
    {"locale":"de","name":"Trizepsdrücken am Kabel","primary":true},{"locale":"de","name":"Pushdown"},
    {"locale":"it","name":"Pushdown ai cavi","primary":true},{"locale":"it","name":"Estensioni ai cavi"}]},

  {"name":"Skull Crusher","category":"isolation","muscles":["triceps"],"names":[
    {"locale":"en","name":"Skull Crusher","primary":true},{"locale":"en","name":"Lying Triceps Extension"},{"locale":"en","name":"French Press"},
    {"locale":"fr","name":"Barre au front","primary":true},{"locale":"fr","name":"Extension couché"},
    {"locale":"es","name":"Press francés","primary":true},{"locale":"es","name":"Rompecráneos"},
    {"locale":"de","name":"French Press","primary":true},{"locale":"de","name":"Stirndrücken"},
    {"locale":"it","name":"French press","primary":true},{"locale":"it","name":"Distensioni su panca per tricipiti"}]},

  {"name":"Overhead Triceps Extension","category":"isolation","muscles":["triceps"],"names":[
    {"locale":"en","name":"Overhead Triceps Extension","primary":true},{"locale":"en","name":"Overhead Extension"},
    {"locale":"fr","name":"Extension nuque","primary":true},{"locale":"fr","name":"Extension triceps au-dessus de la tête"},
    {"locale":"es","name":"Extensión de tríceps sobre la cabeza","primary":true},{"locale":"es","name":"Extensión tras nuca"},
    {"locale":"de","name":"Trizepsdrücken über Kopf","primary":true},
    {"locale":"it","name":"Estensioni sopra la testa","primary":true},{"locale":"it","name":"French press in piedi"}]},

  {"name":"Close-Grip Bench Press","category":"compound","muscles":["triceps","chest"],"names":[
    {"locale":"en","name":"Close-Grip Bench Press","primary":true},
    {"locale":"fr","name":"Développé couché prise serrée","primary":true},{"locale":"fr","name":"DC serré"},
    {"locale":"es","name":"Press de banca agarre cerrado","primary":true},
    {"locale":"de","name":"Enges Bankdrücken","primary":true},
    {"locale":"it","name":"Panca piana presa stretta","primary":true}]},

  {"name":"Back Squat","category":"compound","muscles":["quads","glutes"],"names":[
    {"locale":"en","name":"Back Squat","primary":true},{"locale":"en","name":"Barbell Squat"},{"locale":"en","name":"Squat"},
    {"locale":"fr","name":"Squat","primary":true},{"locale":"fr","name":"Squat barre"},{"locale":"fr","name":"Squat arrière"},
    {"locale":"es","name":"Sentadilla","primary":true},{"locale":"es","name":"Sentadilla trasera"},
    {"locale":"de","name":"Kniebeuge","primary":true},{"locale":"de","name":"Langhantel-Kniebeuge"},
    {"locale":"it","name":"Squat","primary":true},{"locale":"it","name":"Squat con bilanciere"}]},

  {"name":"Front Squat","category":"compound","muscles":["quads","glutes"],"names":[
    {"locale":"en","name":"Front Squat","primary":true},
    {"locale":"fr","name":"Squat avant","primary":true},{"locale":"fr","name":"Front squat"},
    {"locale":"es","name":"Sentadilla frontal","primary":true},
    {"locale":"de","name":"Frontkniebeuge","primary":true},
    {"locale":"it","name":"Front squat","primary":true},{"locale":"it","name":"Squat frontale"}]},

  {"name":"Leg Press","category":"compound","muscles":["quads","glutes"],"names":[
    {"locale":"en","name":"Leg Press","primary":true},
    {"locale":"fr","name":"Presse à cuisses","primary":true},{"locale":"fr","name":"Presse à jambes"},
    {"locale":"es","name":"Prensa de piernas","primary":true},
    {"locale":"de","name":"Beinpresse","primary":true},
    {"locale":"it","name":"Leg press","primary":true},{"locale":"it","name":"Pressa per gambe"}]},

  {"name":"Leg Extension","category":"isolation","muscles":["quads"],"names":[
    {"locale":"en","name":"Leg Extension","primary":true},
    {"locale":"fr","name":"Leg extension","primary":true},{"locale":"fr","name":"Extension des jambes"},
    {"locale":"es","name":"Extensión de cuádriceps","primary":true},{"locale":"es","name":"Extensión de piernas"},
    {"locale":"de","name":"Beinstrecker","primary":true},
    {"locale":"it","name":"Leg extension","primary":true},{"locale":"it","name":"Estensioni delle gambe"}]},

  {"name":"Lunge","category":"compound","muscles":["quads","glutes"],"names":[
    {"locale":"en","name":"Lunge","primary":true},{"locale":"en","name":"Walking Lunge"},{"locale":"en","name":"Dumbbell Lunge"},
    {"locale":"fr","name":"Fente","primary":true},{"locale":"fr","name":"Fentes marchées"},
    {"locale":"es","name":"Zancada","primary":true},{"locale":"es","name":"Estocada"},
    {"locale":"de","name":"Ausfallschritt","primary":true},{"locale":"de","name":"Lunges"},
    {"locale":"it","name":"Affondi","primary":true}]},

  {"name":"Bulgarian Split Squat","category":"compound","muscles":["quads","glutes"],"names":[
    {"locale":"en","name":"Bulgarian Split Squat","primary":true},{"locale":"en","name":"Rear-Foot-Elevated Split Squat"},
    {"locale":"fr","name":"Squat bulgare","primary":true},{"locale":"fr","name":"Fente bulgare"},
    {"locale":"es","name":"Sentadilla búlgara","primary":true},{"locale":"es","name":"Zancada búlgara"},
    {"locale":"de","name":"Bulgarische Kniebeuge","primary":true},{"locale":"de","name":"Split Squat"},
    {"locale":"it","name":"Squat bulgaro","primary":true},{"locale":"it","name":"Affondo bulgaro"}]},

  {"name":"Romanian Deadlift","category":"compound","muscles":["hamstrings","glutes"],"names":[
    {"locale":"en","name":"Romanian Deadlift","primary":true},{"locale":"en","name":"Stiff-Leg Deadlift"},
    {"locale":"fr","name":"Soulevé de terre roumain","primary":true},{"locale":"fr","name":"SDT roumain"},
    {"locale":"es","name":"Peso muerto rumano","primary":true},
    {"locale":"de","name":"Rumänisches Kreuzheben","primary":true},
    {"locale":"it","name":"Stacco rumeno","primary":true},{"locale":"it","name":"Stacco a gambe tese"},
    {"locale":null,"name":"RDL"}]},

  {"name":"Leg Curl","category":"isolation","muscles":["hamstrings"],"names":[
    {"locale":"en","name":"Leg Curl","primary":true},{"locale":"en","name":"Lying Leg Curl"},{"locale":"en","name":"Hamstring Curl"},
    {"locale":"fr","name":"Leg curl","primary":true},{"locale":"fr","name":"Curl des ischios"},{"locale":"fr","name":"Flexion des jambes"},
    {"locale":"es","name":"Curl femoral","primary":true},{"locale":"es","name":"Curl de piernas"},
    {"locale":"de","name":"Beinbeuger","primary":true},
    {"locale":"it","name":"Leg curl","primary":true},{"locale":"it","name":"Curl delle gambe"}]},

  {"name":"Hip Thrust","category":"compound","muscles":["glutes","hamstrings"],"names":[
    {"locale":"en","name":"Hip Thrust","primary":true},{"locale":"en","name":"Barbell Hip Thrust"},
    {"locale":"fr","name":"Hip thrust","primary":true},{"locale":"fr","name":"Poussée de hanches"},
    {"locale":"es","name":"Empuje de cadera","primary":true},{"locale":"es","name":"Hip thrust"},
    {"locale":"de","name":"Hip Thrust","primary":true},{"locale":"de","name":"Hüftstoß"},
    {"locale":"it","name":"Hip thrust","primary":true},{"locale":"it","name":"Spinte dell'anca"}]},

  {"name":"Glute Bridge","category":"isolation","muscles":["glutes"],"names":[
    {"locale":"en","name":"Glute Bridge","primary":true},
    {"locale":"fr","name":"Pont fessier","primary":true},{"locale":"fr","name":"Relevé de bassin"},
    {"locale":"es","name":"Puente de glúteos","primary":true},
    {"locale":"de","name":"Glute Bridge","primary":true},{"locale":"de","name":"Beckenheben"},
    {"locale":"it","name":"Ponte per glutei","primary":true}]},

  {"name":"Standing Calf Raise","category":"isolation","muscles":["calves"],"names":[
    {"locale":"en","name":"Standing Calf Raise","primary":true},{"locale":"en","name":"Calf Raise"},
    {"locale":"fr","name":"Extension mollets debout","primary":true},{"locale":"fr","name":"Mollets debout"},
    {"locale":"es","name":"Elevación de gemelos de pie","primary":true},{"locale":"es","name":"Gemelos de pie"},
    {"locale":"de","name":"Wadenheben stehend","primary":true},
    {"locale":"it","name":"Calf raise in piedi","primary":true},{"locale":"it","name":"Sollevamento polpacci in piedi"}]},

  {"name":"Plank","category":"isometric","muscles":["abs"],"names":[
    {"locale":"en","name":"Plank","primary":true},
    {"locale":"fr","name":"Planche","primary":true},{"locale":"fr","name":"Gainage"},
    {"locale":"es","name":"Plancha","primary":true},
    {"locale":"de","name":"Unterarmstütz","primary":true},{"locale":"de","name":"Plank"},
    {"locale":"it","name":"Plank","primary":true}]},

  {"name":"Crunch","category":"isolation","muscles":["abs"],"names":[
    {"locale":"en","name":"Crunch","primary":true},
    {"locale":"fr","name":"Crunch","primary":true},{"locale":"fr","name":"Relevé de buste"},
    {"locale":"es","name":"Encogimiento abdominal","primary":true},{"locale":"es","name":"Crunch"},
    {"locale":"de","name":"Crunches","primary":true},{"locale":"de","name":"Bauchpressen"},
    {"locale":"it","name":"Crunch","primary":true}]},

  {"name":"Hanging Leg Raise","category":"isolation","muscles":["abs"],"names":[
    {"locale":"en","name":"Hanging Leg Raise","primary":true},{"locale":"en","name":"Hanging Knee Raise"},
    {"locale":"fr","name":"Relevé de jambes suspendu","primary":true},{"locale":"fr","name":"Relevé de genoux suspendu"},
    {"locale":"es","name":"Elevación de piernas colgado","primary":true},
    {"locale":"de","name":"Hängendes Beinheben","primary":true},
    {"locale":"it","name":"Sollevamento gambe alla sbarra","primary":true}]},

  {"name":"Russian Twist","category":"isolation","muscles":["abs"],"names":[
    {"locale":"en","name":"Russian Twist","primary":true},
    {"locale":"fr","name":"Russian twist","primary":true},{"locale":"fr","name":"Rotation russe"},
    {"locale":"es","name":"Giro ruso","primary":true},
    {"locale":"de","name":"Russian Twist","primary":true},
    {"locale":"it","name":"Russian twist","primary":true},{"locale":"it","name":"Torsioni russe"}]},

  {"name":"Cable Crunch","category":"isolation","muscles":["abs"],"names":[
    {"locale":"en","name":"Cable Crunch","primary":true},
    {"locale":"fr","name":"Crunch à la poulie","primary":true},
    {"locale":"es","name":"Crunch en polea","primary":true},
    {"locale":"de","name":"Kabelcrunch","primary":true},
    {"locale":"it","name":"Crunch ai cavi","primary":true}]}
]
$j$::jsonb)
  LOOP
    INSERT INTO exercises (name, is_certified, user_id, muscle_groups, category)
    VALUES (
      rec->>'name',
      true,
      NULL,
      ARRAY(SELECT jsonb_array_elements_text(rec->'muscles')),
      rec->>'category'
    )
    ON CONFLICT (lower(name)) WHERE is_certified
      DO UPDATE SET muscle_groups = EXCLUDED.muscle_groups,
                    category = EXCLUDED.category
    RETURNING id INTO ex_id;

    FOR nm IN SELECT value FROM jsonb_array_elements(rec->'names')
    LOOP
      INSERT INTO exercise_names (exercise_id, locale, name, is_primary)
      VALUES (
        ex_id,
        nm->>'locale',
        nm->>'name',
        COALESCE((nm->>'primary')::boolean, false)
      )
      ON CONFLICT (exercise_id, (COALESCE(locale, '')), name) DO NOTHING;
    END LOOP;
  END LOOP;
END
$do$;
