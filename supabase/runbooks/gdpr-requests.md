# Runbook — demandes RGPD

Procédures à suivre quand un utilisateur écrit à `admin@aevon.studio`. Les
délais et le périmètre viennent de la politique de confidentialité (§8 et §9) et
des CGU (§14) : **si tu changes quelque chose ici, vérifie que les quatre
documents disent toujours la même chose.**

Délai de réponse annoncé : **un mois**, prolongeable de deux si la demande est
complexe, à condition d'en expliquer la raison dans le premier mois.

Toutes les requêtes ci-dessous se lancent depuis le **SQL Editor** du dashboard
Supabase, qui s'exécute avec le rôle `postgres`.

---

## 1. Retrouver l'utilisateur

Vérifie d'abord que la demande vient bien de l'adresse du compte — c'est la
seule authentification dont on dispose.

```sql
select id, email, created_at, last_sign_in_at
from auth.users
where email = 'adresse@exemple.com';
```

Si l'adresse ne correspond à aucun compte, réponds-le : ne cherche pas par nom.

---

## 2. Droit d'accès / portabilité (§9)

```sql
select jsonb_pretty(public.export_user_data('<uid>'));
```

Renvoie tout : compte, profil (objectif, taille, poids, date de naissance,
langue), exercices personnels, templates avec leurs exercices, séances avec
leurs exercices et leurs séries, et les messages de support encore rattachés au
compte. Le catalogue d'exercices certifiés en est exclu — il est à nous, pas à
l'utilisateur.

Enregistre le résultat en `.json` et envoie-le en pièce jointe.

**La photo de profil n'est pas dans le JSON** (l'export signale son chemin).
Si l'utilisateur en a une, télécharge `avatars/<uid>/avatar.jpg` depuis Storage
et joins-la aussi.

---

## 3. Droit à l'effacement (§9, et page de suppression de compte)

Dans l'ordre. Les tables métier partent en cascade via
`ON DELETE CASCADE` sur `auth.users`, mais **ni le fichier avatar ni les
messages de support n'en font partie**.

**a. Supprimer l'avatar.** Storage → bucket `avatars` → dossier `<uid>` →
supprimer. La cascade SQL ne touche pas le stockage objet.

**b. Supprimer le compte.** Authentication → Users → `…` → *Delete user*.
Emporte avec lui `exercises`, `workout_templates`, `template_exercises`,
`workout_sessions`, `session_exercises` et `session_sets`.

**c. Décider du sort des messages de support.** Ils sont conservés
volontairement : `contact_requests.user_id` passe à `NULL` mais le nom,
l'e-mail et le message restent. C'est annoncé au §8 de la politique. Si
l'utilisateur demande explicitement leur effacement, il y a droit :

```sql
delete from contact_requests where email = 'adresse@exemple.com';
```

**d. Vérifier.** Aucune ligne ne doit subsister :

```sql
select
  (select count(*) from exercises          where user_id = '<uid>') as exercises,
  (select count(*) from workout_templates  where user_id = '<uid>') as templates,
  (select count(*) from workout_sessions   where user_id = '<uid>') as sessions,
  (select count(*) from contact_requests   where user_id = '<uid>') as support;
```

Délai annoncé : **30 jours maximum**.

---

## 4. Droit de rectification (§9)

À renvoyer vers l'app : l'écran Profil édite le nom, l'objectif, la taille, le
poids, la date de naissance et l'avatar. Aucune intervention manuelle requise.

---

## 5. Retrait du consentement (§5, §9)

Taille, poids et date de naissance reposent sur le consentement. Les effacer
depuis le profil suffit. En manuel si besoin :

```sql
update auth.users
set raw_user_meta_data = raw_user_meta_data - 'height' - 'weight' - 'birthdate'
where id = '<uid>';
```

---

## 6. Formulaire de contact — notification

Chaque insertion dans `contact_requests` déclenche `contact_request_notify`,
qui poste la ligne à l'edge function `on-contact-request`, qui l'envoie par
e-mail à `admin@aevon.studio`. Répondre au mail répond directement à la
personne (`reply_to` porte son adresse).

**La table reste la source de vérité.** Le mail est un confort : le trigger
avale ses propres erreurs pour qu'une notification ratée ne fasse jamais
échouer l'enregistrement d'un message. Un mail non reçu ne veut donc pas dire
qu'il n'y a pas de message.

Diagnostic quand rien n'arrive :

```sql
-- Le POST est-il parti, et qu'a répondu la fonction ?
select status_code, error_msg, left(content, 200), created
from net._http_response order by created desc limit 5;
```

Un résultat **vide** signifie que le POST n'est jamais parti (secrets Vault
absents, ou erreur avalée par le garde-fou) — pas qu'il a réussi. Vérifier
alors que les deux secrets existent :

```sql
select name from vault.decrypted_secrets
where name in ('contact_hook_url', 'contact_hook_secret');
```

Un `500 not configured` signifie que la fonction est joignable mais qu'il lui
manque `RESEND_API_KEY` ou `CONTACT_HOOK_SECRET` dans ses secrets
(dashboard → Edge Functions → on-contact-request → Secrets).

Et dans tous les cas, relire la boîte de temps en temps :

```sql
select created_at, name, email, category, message
from contact_requests order by created_at desc limit 20;
```

## 7. Rétention automatique

Les journaux d'authentification sont purgés à 12 mois par un job pg_cron
hebdomadaire (`purge-auth-audit-logs`, dimanche 03:00 UTC). Pour le contrôler :

```sql
select jobname, schedule, active from cron.job;
select * from cron.job_run_details
where jobname = 'purge-auth-audit-logs'
order by start_time desc limit 5;
```

Purge manuelle si nécessaire : `select public.purge_auth_audit_logs();`
(retourne le nombre de lignes supprimées).
