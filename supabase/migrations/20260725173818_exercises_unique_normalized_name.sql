-- ============================================================
-- Repster — Unicité des exercices par nom normalisé
-- ------------------------------------------------------------
-- `exercises_user_id_name_key` (user_id, name) n'empêchait que les doublons
-- au caractère près. En pratique la base avait accumulé des paires comme
-- « Machine dips » / « Machine Dips », « Spider curl » / « Spider Curl »,
-- ainsi qu'une trentaine de noms à espace final venus de la PWA (pas de trim
-- à la saisie). Chaque doublon scinde l'historique de l'utilisateur en deux
-- lignées : l'exercice apparaît deux fois, et les stats de progression comme
-- le pré-remplissage « la dernière fois » ne voient qu'une moitié des séries.
--
-- On rend donc l'unicité insensible à la casse, aux accents et aux espaces
-- surnuméraires, avec la MÊME normalisation que le client
-- (`exerciseNameKey` dans lib/core/exercises/exercise_identity.dart) :
--   trim + espaces internes réduits + minuscules + accents retirés
--
-- ⚠ Le client doit résoudre un exercice existant par ce nom normalisé AVANT
-- d'insérer. Son `upsert(onConflict: 'user_id,name')` ne cible que l'index
-- exact : sans cette résolution préalable, une variante de casse ne serait
-- plus dédoublonnée en silence mais rejetée (23505), ce qui ferait échouer
-- l'enregistrement d'une séance.
--
-- Prérequis vérifié avant écriture : 0 collision sur les 144 lignes concernées.
-- ============================================================

-- Lignes certifiées exclues : leur user_id est NULL (donc jamais en conflit
-- dans un index unique) et elles ont déjà `exercises_certified_name_key`.
CREATE UNIQUE INDEX IF NOT EXISTS exercises_user_normalized_name_key
  ON exercises (
    user_id,
    public.f_unaccent(lower(btrim(regexp_replace(name, '\s+', ' ', 'g'))))
  )
  WHERE user_id IS NOT NULL;

COMMENT ON INDEX exercises_user_normalized_name_key IS
  'Unicité par utilisateur insensible casse/accents/espaces. Miroir de exerciseNameKey() côté client.';
