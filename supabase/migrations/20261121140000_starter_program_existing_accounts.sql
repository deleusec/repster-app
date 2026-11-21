-- ============================================================
-- Repster — Starter program on accounts that already have sessions
-- ------------------------------------------------------------
-- `seed_starter_program` gains `p_active`: an account that already has its
-- own sessions gets the program switched off, filed after its other
-- programs and sessions, so nothing it uses changes. The blank-account guard
-- moves to the sign-up trigger, where every account is blank anyway.
-- Same program as 20261121120000.
-- ============================================================

DROP FUNCTION IF EXISTS public.seed_starter_program(UUID, TEXT);

CREATE OR REPLACE FUNCTION public.seed_starter_program(
  p_user UUID,
  p_language TEXT,
  p_active BOOLEAN DEFAULT TRUE
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  lang TEXT := CASE
    WHEN p_language IS NULL THEN 'fr'
    WHEN p_language IN ('en', 'fr', 'es', 'de', 'it') THEN p_language
    ELSE 'en'
  END;
  spec JSONB := $j$
{
  "name": {
    "en": "Beginner full body",
    "fr": "Débutant full body",
    "es": "Principiante cuerpo completo",
    "de": "Einsteiger Ganzkörper",
    "it": "Principiante total body"
  },
  "description": {
    "en": "3 sessions a week, with a rest day between each. When you complete every rep of every set, add a little weight next time.",
    "fr": "3 séances par semaine, avec un jour de repos entre chaque. Quand tu réussis toutes les reps de toutes les séries, ajoute un peu de poids la fois suivante.",
    "es": "3 sesiones por semana, con un día de descanso entre cada una. Cuando completes todas las repeticiones de todas las series, añade un poco de peso la próxima vez.",
    "de": "3 Einheiten pro Woche, mit einem Ruhetag dazwischen. Schaffst du alle Wiederholungen in allen Sätzen, nimm beim nächsten Mal etwas mehr Gewicht.",
    "it": "3 sedute a settimana, con un giorno di riposo tra l'una e l'altra. Quando completi tutte le ripetizioni di tutte le serie, aggiungi un po' di peso la volta successiva."
  },
  "sessions": [
    {
      "emoji": "person-lifting-weights",
      "name": {"en": "Full body 1", "fr": "Full body 1", "es": "Cuerpo completo 1", "de": "Ganzkörper 1", "it": "Total body 1"},
      "exercises": [
        {"exercise": "Leg Press", "sets": 3, "reps": 10, "rest": 120, "notes": {
          "en": "Feet shoulder-width apart, don't lock your knees at the top.",
          "fr": "Pieds largeur d'épaules, ne verrouille pas les genoux en haut.",
          "es": "Pies a la anchura de los hombros, no bloquees las rodillas arriba.",
          "de": "Füße schulterbreit, Knie oben nicht durchdrücken.",
          "it": "Piedi alla larghezza delle spalle, non bloccare le ginocchia in alto."}},
        {"exercise": "Dumbbell Bench Press", "sets": 3, "reps": 10, "rest": 90, "notes": {
          "en": "Lower the dumbbells slowly to chest level.",
          "fr": "Descends les haltères lentement jusqu'à hauteur de poitrine.",
          "es": "Baja las mancuernas despacio hasta la altura del pecho.",
          "de": "Senke die Kurzhanteln langsam bis auf Brusthöhe.",
          "it": "Scendi lentamente con i manubri fino all'altezza del petto."}},
        {"exercise": "Lat Pulldown", "sets": 3, "reps": 10, "rest": 90, "notes": {
          "en": "Pull the bar to your upper chest, without swinging.",
          "fr": "Tire la barre vers le haut de la poitrine, sans te balancer.",
          "es": "Lleva la barra a la parte alta del pecho, sin balancearte.",
          "de": "Zieh die Stange zur oberen Brust, ohne Schwung.",
          "it": "Tira la barra verso la parte alta del petto, senza dondolare."}},
        {"exercise": "Leg Curl", "sets": 3, "reps": 12, "rest": 60},
        {"exercise": "Lateral Raise", "sets": 3, "reps": 12, "rest": 60, "notes": {
          "en": "Light weight, raise to shoulder height.",
          "fr": "Charge légère, monte jusqu'à hauteur d'épaules.",
          "es": "Peso ligero, sube hasta la altura de los hombros.",
          "de": "Leichtes Gewicht, bis auf Schulterhöhe heben.",
          "it": "Peso leggero, sali fino all'altezza delle spalle."}},
        {"exercise": "Plank", "sets": 3, "seconds": 30, "rest": 60, "notes": {
          "en": "Body in a straight line, glutes and abs tight.",
          "fr": "Corps aligné, fessiers et abdos serrés.",
          "es": "Cuerpo alineado, glúteos y abdomen apretados.",
          "de": "Körper in einer Linie, Po und Bauch angespannt.",
          "it": "Corpo allineato, glutei e addominali contratti."}}
      ]
    },
    {
      "emoji": "flexed-biceps",
      "name": {"en": "Full body 2", "fr": "Full body 2", "es": "Cuerpo completo 2", "de": "Ganzkörper 2", "it": "Total body 2"},
      "exercises": [
        {"exercise": "Romanian Deadlift", "sets": 3, "reps": 10, "rest": 120, "notes": {
          "en": "Back flat, push your hips back, keep the bar close to your legs.",
          "fr": "Dos plat, pousse les hanches vers l'arrière, barre près des jambes.",
          "es": "Espalda recta, lleva la cadera atrás, la barra pegada a las piernas.",
          "de": "Rücken gerade, Hüfte nach hinten schieben, Stange nah an den Beinen.",
          "it": "Schiena piatta, spingi i fianchi indietro, bilanciere vicino alle gambe."}},
        {"exercise": "Dumbbell Shoulder Press", "sets": 3, "reps": 10, "rest": 90, "notes": {
          "en": "Don't arch your lower back.",
          "fr": "Ne cambre pas le bas du dos.",
          "es": "No arquees la zona lumbar.",
          "de": "Kein Hohlkreuz.",
          "it": "Non inarcare la zona lombare."}},
        {"exercise": "Seated Cable Row", "sets": 3, "reps": 10, "rest": 90, "notes": {
          "en": "Chest up, squeeze your shoulder blades at the end.",
          "fr": "Buste droit, serre les omoplates en fin de mouvement.",
          "es": "Pecho arriba, junta los omóplatos al final.",
          "de": "Brust raus, Schulterblätter am Ende zusammenziehen.",
          "it": "Petto in fuori, stringi le scapole alla fine."}},
        {"exercise": "Lunge", "sets": 3, "reps": 10, "rest": 90, "notes": {
          "en": "10 reps per leg.",
          "fr": "10 reps par jambe.",
          "es": "10 repeticiones por pierna.",
          "de": "10 Wiederholungen pro Bein.",
          "it": "10 ripetizioni per gamba."}},
        {"exercise": "Dumbbell Curl", "sets": 3, "reps": 12, "rest": 60},
        {"exercise": "Crunch", "sets": 3, "reps": 15, "rest": 60}
      ]
    },
    {
      "emoji": "leg",
      "name": {"en": "Full body 3", "fr": "Full body 3", "es": "Cuerpo completo 3", "de": "Ganzkörper 3", "it": "Total body 3"},
      "exercises": [
        {"exercise": "Back Squat", "sets": 3, "reps": 8, "rest": 120, "notes": {
          "en": "Start with the empty bar to learn the movement.",
          "fr": "Commence à la barre à vide pour apprendre le mouvement.",
          "es": "Empieza con la barra vacía para aprender el movimiento.",
          "de": "Beginne mit der leeren Stange, um die Bewegung zu lernen.",
          "it": "Inizia con il bilanciere scarico per imparare il movimento."}},
        {"exercise": "Push-Up", "sets": 3, "reps": 10, "rest": 90, "notes": {
          "en": "On your knees if needed.",
          "fr": "Sur les genoux si besoin.",
          "es": "Con las rodillas apoyadas si hace falta.",
          "de": "Bei Bedarf auf den Knien.",
          "it": "Sulle ginocchia se serve."}},
        {"exercise": "Dumbbell Row", "sets": 3, "reps": 10, "rest": 90, "notes": {
          "en": "10 reps per arm, back flat.",
          "fr": "10 reps par bras, dos plat.",
          "es": "10 repeticiones por brazo, espalda recta.",
          "de": "10 Wiederholungen pro Arm, Rücken gerade.",
          "it": "10 ripetizioni per braccio, schiena piatta."}},
        {"exercise": "Hip Thrust", "sets": 3, "reps": 10, "rest": 90, "notes": {
          "en": "Hold one second at the top.",
          "fr": "Marque une pause d'une seconde en haut.",
          "es": "Mantén un segundo arriba.",
          "de": "Oben eine Sekunde halten.",
          "it": "Tieni un secondo in alto."}},
        {"exercise": "Triceps Pushdown", "sets": 3, "reps": 12, "rest": 60, "notes": {
          "en": "Elbows tucked against your sides.",
          "fr": "Coudes collés au corps.",
          "es": "Codos pegados al cuerpo.",
          "de": "Ellbogen eng am Körper.",
          "it": "Gomiti stretti al corpo."}},
        {"exercise": "Face Pull", "sets": 3, "reps": 15, "rest": 60, "notes": {
          "en": "Pull toward your forehead, elbows high.",
          "fr": "Tire vers le front, coudes hauts.",
          "es": "Tira hacia la frente, codos altos.",
          "de": "Zur Stirn ziehen, Ellbogen hoch.",
          "it": "Tira verso la fronte, gomiti alti."}}
      ]
    }
  ]
}
$j$;
  v_program UUID;
  v_template UUID;
  v_exercise UUID;
  v_program_pos INT;
  v_template_pos INT;
  s RECORD;
  e RECORD;
BEGIN
  SELECT COALESCE(MAX(position) + 1, 0) INTO v_program_pos
  FROM programs WHERE user_id = p_user;
  SELECT COALESCE(MAX(position) + 1, 0) INTO v_template_pos
  FROM workout_templates WHERE user_id = p_user;

  -- One active program per user: switching this one on is the user's call.
  IF p_active AND EXISTS (
    SELECT 1 FROM programs WHERE user_id = p_user AND is_active
  ) THEN
    p_active := FALSE;
  END IF;

  INSERT INTO programs (user_id, name, position, is_active)
  VALUES (p_user, spec -> 'name' ->> lang, v_program_pos, p_active)
  RETURNING id INTO v_program;

  FOR s IN
    SELECT value AS session, ordinality - 1 AS position
    FROM jsonb_array_elements(spec -> 'sessions') WITH ORDINALITY
  LOOP
    INSERT INTO workout_templates
      (user_id, program_id, name, description, emoji, position, is_active)
    VALUES (
      p_user,
      v_program,
      s.session -> 'name' ->> lang,
      spec -> 'description' ->> lang,
      s.session ->> 'emoji',
      v_template_pos + s.position,
      p_active
    )
    RETURNING id INTO v_template;

    FOR e IN
      SELECT value AS exercise, ordinality - 1 AS position
      FROM jsonb_array_elements(s.session -> 'exercises') WITH ORDINALITY
    LOOP
      SELECT id INTO v_exercise
      FROM exercises
      WHERE is_certified
        AND user_id IS NULL
        AND lower(name) = lower(e.exercise ->> 'exercise');

      -- A catalogue rename must not break sign-up: drop the exercise instead.
      CONTINUE WHEN v_exercise IS NULL;

      INSERT INTO template_exercises (
        template_id, exercise_id, position, sets_count, reps_target,
        is_time_based, duration_seconds, tempo, rest_seconds, notes
      )
      VALUES (
        v_template,
        v_exercise,
        e.position,
        (e.exercise ->> 'sets')::INT,
        (e.exercise ->> 'reps')::INT,
        e.exercise ? 'seconds',
        (e.exercise ->> 'seconds')::INT,
        '2-0-2-0',
        (e.exercise ->> 'rest')::INT,
        e.exercise -> 'notes' ->> lang
      );
    END LOOP;
  END LOOP;
END;
$$;

REVOKE ALL ON FUNCTION public.seed_starter_program(UUID, TEXT, BOOLEAN)
  FROM PUBLIC, anon, authenticated;

CREATE OR REPLACE FUNCTION public.handle_new_user_starter_program()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
  -- Never let the starter program fail a sign-up.
  BEGIN
    IF NOT EXISTS (SELECT 1 FROM programs WHERE user_id = NEW.id)
       AND NOT EXISTS (SELECT 1 FROM workout_templates WHERE user_id = NEW.id)
    THEN
      PERFORM public.seed_starter_program(
        NEW.id,
        NEW.raw_user_meta_data ->> 'signup_language'
      );
    END IF;
  EXCEPTION WHEN OTHERS THEN
    RAISE WARNING 'starter program not created for %: %', NEW.id, SQLERRM;
  END;
  RETURN NEW;
END;
$$;
