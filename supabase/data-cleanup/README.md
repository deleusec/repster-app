# Scripts d'annulation — nettoyage de données

> ⚠️ Ce dossier n'est **pas** des migrations. Il est volontairement en dehors de
> `supabase/migrations/` pour que le CLI ne le rejoue jamais. Chaque fichier est
> un `BEGIN … COMMIT` à exécuter **à la main**, uniquement pour revenir en
> arrière sur une opération de nettoyage.

Les migrations décrivent le *schéma*. Ces scripts décrivent des corrections de
*données* ponctuelles — non rejouables sur un environnement neuf, puisqu'elles
ne s'appliquent qu'aux lignes qui existaient à ce moment-là.

## 2026-07-25 — dédoublonnage et harmonisation des exercices

Contexte : `exercises` avait accumulé 33 doublons (casse, accents, espaces
finaux issus de la saisie PWA sans `trim`) et 20 lignes orphelines. Chaque
doublon scindait l'historique d'un exercice en deux lignées, faussant les
progressions et le pré-remplissage « la dernière fois ».

Ordre chronologique d'application. Pour annuler, exécuter en ordre **inverse** —
l'ordre compte, chaque script fait passer la base de l'état N à l'état N-1 et
suppose que les suivants ont déjà été annulés.

### ⚠ Deux limites, vérifiées en conditions réelles

**1. `restore_classeA_merge.sql` ne peut pas s'exécuter tel quel.** Il recrée des
doublons qui ne diffèrent que par la casse (`Machine dips` / `Machine Dips`), ce
que l'index `exercises_user_normalized_name_key` interdit maintenant. Test à
blanc : `duplicate key value violates unique constraint
"exercises_user_normalized_name_key"`. Il faut donc encadrer l'annulation :

```sql
DROP INDEX exercises_user_normalized_name_key;
-- … les scripts, en ordre inverse …
-- puis recréer l'index (cf. migration 20260725173818)
```

**2. L'ordre interne des étapes est impératif** dans les scripts de fusion :
rendre son nom au gagnant **avant** de recréer la ligne absorbée. Sinon les deux
portent le même nom le temps d'une instruction et
`exercises_user_id_name_key` rejette l'insertion. Les scripts livrés ici sont
déjà dans le bon ordre — c'était un défaut de la première version.

| Script | Opération |
|---|---|
| `restore_orphan_exercises.sql` | 20 exos orphelins supprimés (aucune référence template ni séance) |
| `restore_classeA_merge.sql` | 4 groupes de doublons de casse fusionnés |
| `restore_classeB_merge.sql` | 7 exos perso rattachés au catalogue certifié (sans template) |
| `restore_classeB2_merge.sql` | 7 exos perso rattachés au catalogue certifié (avec template) |
| `restore_classeC_merge.sql` | 3 groupes fusionnés après arbitrage manuel |
| `restore_noms_exos.sql` | 111 espaces finaux retirés + 3 casses corrigées |
| `restore_noms_style.sql` | 5 renommages de style (français, pluriel) |
| `restore_noms_axelejan.sql` | 5 fautes corrigées + 3 fusions (compte axelejan) |
| `restore_noms_axelejan2.sql` | 3 accords corrigés + 4 fusions (compte axelejan) |

Bilan : 236 → 185 exercices, **aucune série perdue** (2015 séries et
653 180 kg de tonnage avant comme après), 48 exos certifiés jamais touchés.

## Pourquoi ces scripts existent

`session_exercises` **snapshote** le nom de l'exercice en plus de son
`exercise_id`, et `fetchExerciseHistory` matche sur ce nom. Toute fusion ou
renommage doit donc réécrire les deux, sinon l'historique se scinde. C'est
irréversible sans les valeurs d'avant — d'où ces scripts, qui contiennent les
`id` et les noms d'origine ligne par ligne.

Ce qui a rendu ces doublons structurellement impossibles depuis :

- `exercises_user_normalized_name_key` (migration `20260725173818`) — unicité
  par utilisateur insensible casse/accents/espaces
- `ExerciseResolver` (`lib/core/exercises/exercise_identity.dart`) et son
  miroir PWA (`lib/exercise-identity.ts`) — résolution par nom normalisé, et
  déférence au catalogue certifié, avant toute insertion
