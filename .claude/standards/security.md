# Security

## Secrets

| Type | Stockage | Pourquoi |
|---|---|---|
| `SUPABASE_ANON_KEY` | `.env` + `--dart-define-from-file` | Publique par design (RLS fait la sécurité) |
| `SUPABASE_SERVICE_ROLE` | ❌ **JAMAIS** dans l'app | Bypass RLS = catastrophe |
| Sentry DSN, autres clés publiques | `.env` | OK si conçues pour être publiques |
| Tokens utilisateur (session Supabase) | `SecureLocalStorage` (Keychain iOS / EncryptedSharedPreferences Android) — voir `lib/core/supabase/secure_local_storage.dart` | Ne jamais relire/relogger |

**Audit régulier** :
```bash
git grep -i "service_role\|sk_live\|sk_prod" -- ':!*.md'   # doit retourner 0
```

## Logging

`AppLogger` est le seul canal de log. Règles :

- ❌ Ne **jamais** logger un token JWT, refresh token, ou contenu de session.
- ❌ Ne **jamais** logger un mot de passe (même hashé).
- ✅ Logger les `AppException` avec `error:` + `stackTrace:`.
- ✅ Logger les actions critiques (signup réussi, séance sauvegardée) en `info`.

## RLS — voir [supabase.md](./supabase.md)

L'autorité de filtrage des données est **Postgres**, pas Dart. Aucun filtre `WHERE user_id` côté client.

## Validation des entrées

Dans `application/` (avant d'appeler le repository) :

```dart
Future<void> create(String rawName) async {
  final name = rawName.trim();
  if (name.isEmpty) {
    throw const ValidationException('Le nom est requis', field: 'name');
  }
  if (name.length > 80) {
    throw const ValidationException('Nom trop long (80 max)', field: 'name');
  }
  await ref.read(repoProvider).create(Template(name: name, …));
}
```

Pas de validation dans `presentation/` (l'UI peut hint, mais la source de vérité est `application/`).

## Stockage local

- **Session Supabase** : `SecureLocalStorage` (adapter custom branché dans `Supabase.initialize`) qui délègue à `flutter_secure_storage`.
  - iOS / macOS → Keychain (`KeychainAccessibility.first_unlock` pour permettre un refresh background sans unlock interactif).
  - Android → `EncryptedSharedPreferences` (AES via Keystore, `encryptedSharedPreferences: true`).
  - ⚠️ Par défaut `supabase_flutter` utilise `SharedPreferencesLocalStorage` qui écrit en **clair** — on l'override volontairement.
- Préférences utilisateur non-sensibles (thème, dernière route…) : `shared_preferences`.
- ❌ **Jamais** de token dans `SharedPreferences` non chiffré.

## Deep links

Quand on activera OAuth / magic links :
- URL scheme déclaré dans `Info.plist` + `AndroidManifest.xml`.
- Valider le `state` param côté app.
- Vérifier que le redirect URL configuré dans Supabase **whiteliste** seulement nos schemes.

## Build release

- [ ] Pas de `print` (lint `avoid_print` actif)
- [ ] `kReleaseMode` actif : `AppLogger` filtre les logs `debug` en prod
- [ ] Build signé (Android keystore, iOS certs) — pas de release avec keys debug
- [ ] `debugShowCheckedModeBanner: false` (déjà le cas)
- [ ] `flutter build apk --obfuscate --split-debug-info=…` pour Android release
- [ ] Idem `--obfuscate` pour iOS

## Crash reporting (futur)

Quand on ajoutera Sentry/Glitchtip :
- DSN dans `.env`
- Hook dans `installGlobalErrorHandlers` (un seul endroit à modifier)
- `beforeSend` qui scrub les tokens éventuels avant l'envoi
