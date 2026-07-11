# AGENTS.md

Guidance pour les agents (Claude Code et autres) dans ce projet.

## Projet

**Repster (mobile)** — Application Flutter, migration de la PWA `../repster-pwa` vers iOS / Android.

Fonctionnalités (même périmètre que la PWA) :
- Création de **templates de séances** (exercices, séries, reps, tempo `3-1-2-0`, repos)
- **Sessions live** lancées depuis un template
- **Visualisation des performances** (stats)

## Commands

```bash
flutter pub get                                              # Install deps
flutter run --dart-define-from-file=.env                     # Run dev (mobile)
flutter run -d chrome --dart-define-from-file=.env           # Run web
flutter analyze                                              # Static analysis
flutter test                                                 # Unit / widget tests
dart run build_runner watch --delete-conflicting-outputs     # Watch codegen
dart run build_runner build --delete-conflicting-outputs     # One-shot codegen
```

> ⚠️ **Toujours passer `--dart-define-from-file=.env`** au `flutter run` / `flutter build`. Sinon `Env.assertConfigured()` lève au démarrage. Voir la config IDE plus bas.

## Stack

- **Flutter 3.38+** / **Dart 3.10+**
- **supabase_flutter** — auth + Postgres (même backend que la PWA)
- **flutter_riverpod 2.6** — state management (providers manuels, voir « Codegen » plus bas)
- **go_router 14** — navigation déclarative avec `StatefulShellRoute.indexedStack`
- **freezed + json_serializable** — modèles immutables et JSON (via `build_runner`)
- **logger** — logging centralisé via `lib/core/logging/app_logger.dart`
- **intl** — formatage dates / nombres
- **very_good_analysis** — lints stricts
- Material 3 (theming via `ColorScheme.fromSeed`)

## Architecture — 4 couches par feature

```
lib/
├── main.dart                          # runZonedAppGuarded + handlers + Supabase init
├── app.dart                           # MaterialApp.router racine
│
├── core/                              # Cross-cutting (zéro dép feature)
│   ├── config/env.dart                # String.fromEnvironment
│   ├── error/
│   │   ├── app_exception.dart         # Hiérarchie sealed (AppException, AppAuthException…)
│   │   └── error_handler.dart         # FlutterError + PlatformDispatcher + zone guard
│   ├── logging/app_logger.dart        # log.i, log.w, log.e
│   ├── router/
│   │   ├── app_router.dart            # go_router + StatefulShellRoute
│   │   └── routes.dart                # Constantes de paths
│   ├── supabase/
│   │   ├── supabase_providers.dart    # client, session, user
│   │   └── postgrest_error_x.dart     # mapSupabaseError → AppException
│   └── theme/app_theme.dart
│
├── features/<name>/                   # auth, templates, sessions, dashboard, profile
│   ├── data/                          # Repositories + DTOs (Supabase only)
│   ├── domain/                        # Modèles Freezed (pur Dart)
│   ├── application/                   # Notifiers Riverpod
│   └── presentation/                  # Écrans + widgets Flutter
│
└── shared/
    └── widgets/
        ├── async_value_widget.dart    # Wrapper standard AsyncValue.when
        ├── app_loading.dart
        ├── app_error.dart             # Connait AppException → message UX
        └── tab_bar_scaffold.dart
```

### Règles de dépendances

Détaillées dans [`.claude/standards/architecture.md`](.claude/standards/architecture.md). En résumé :

| Couche | Importe | N'importe jamais |
|---|---|---|
| `domain/` | Dart pur, freezed | Flutter, Supabase, Riverpod |
| `data/` | `domain/`, supabase_flutter, riverpod¹ | Flutter widgets, `application/`, `presentation/` |
| `application/` | `domain/`, `data/`, riverpod | Flutter widgets, Supabase direct |
| `presentation/` | `domain/`, `application/`, Flutter | `data/` directement |

> ¹ Riverpod dans `data/` : uniquement pour co-localiser le `Provider` de DI du repository (et des `Stream`/`FutureProvider` qui délèguent au repo). Pas de `Notifier` ni de logique — voir [`architecture.md`](.claude/standards/architecture.md).

### Routing

| PWA Next.js                | Flutter (go_router)                                    |
|----------------------------|--------------------------------------------------------|
| `(auth)/login`, `signup`   | `/login`, `/signup`                                    |
| `(app)/*`                  | `StatefulShellRoute.indexedStack` (état par tab conservé) |
| `session/[id]`             | `/session/:templateId` (root navigator, hors tab bar)  |
| `proxy.ts` (auth redirect) | `redirect:` callback dans `goRouterProvider`           |

L'auth state Supabase fait `notifyListeners()` sur le `refreshListenable` de go_router → toute connexion/déconnexion déclenche un re-check du redirect.

### State management — équivalences avec la PWA

| PWA              | Flutter                            |
|------------------|------------------------------------|
| Server Components + Supabase | `FutureProvider` / `StreamProvider` (Riverpod) |
| Server Actions   | Méthodes sur des `Notifier` / `AsyncNotifier` |
| TanStack Query   | Riverpod (`AsyncValue` + `ref.invalidate`) |
| Zustand (session live) | `Notifier` Riverpod scopé à la séance |

### Modèle de données

Même schéma Supabase que la PWA — voir `../repster-pwa/supabase/migrations/` et `../repster-pwa/AGENTS.md`. RLS activée.

## Env

Pas de `flutter_dotenv` — on utilise le mécanisme natif Flutter `--dart-define-from-file`.

- Le fichier `.env` à la racine contient les valeurs (gitignoré).
- `.env.example` documente les clés attendues.
- `lib/core/config/env.dart` les lit via `String.fromEnvironment` (compile-time).
- `Env.assertConfigured()` est appelé dans `main()` — fail-fast si une clé manque.

Clés requises :
- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`

Format `.env` accepté par `--dart-define-from-file` : `KEY=VALUE`, un par ligne, sans guillemets.

### Lancement IDE

- **VSCode** : ajouter à `.vscode/launch.json` un `toolArgs: ["--dart-define-from-file=.env"]`.
- **Android Studio / IntelliJ** : Run Configuration → « Additional run args » → `--dart-define-from-file=.env`.

## Codegen

Toolchain active : **freezed + json_serializable** via `build_runner`.

- `dart run build_runner watch --delete-conflicting-outputs` pendant le dev.
- Les fichiers `*.g.dart` et `*.freezed.dart` sont exclus de l'analyzer (`analysis_options.yaml`).

**Pas de `riverpod_generator`** : sa chaîne (`riverpod_analyzer_utils` → `custom_lint_core 0.7.1` → `analyzer_plugin 0.12.0`) est cassée contre `analyzer 7.x` shippé par Flutter 3.38. On utilise donc les providers Riverpod **manuels** (API standard `Provider`, `StateNotifierProvider`, `AsyncNotifierProvider`). À rebrancher quand l'écosystème s'aligne (probable une fois Riverpod 3.x stable + analyzer plugins mis à jour).

## Conventions

- **Imports absolus** uniquement (`package:repster/…`) — pas de relatifs.
- **Single quotes** par défaut (very_good_analysis).
- **`const` partout** quand possible.
- **Pas de `print`** : utiliser `log.i('msg')` / `log.e('msg', error: e, stackTrace: st)`.
- **Pas d'offline** pour l'instant — connexion active supposée pendant une séance.

## Standards détaillés — `.claude/standards/`

Quand tu travailles sur une couche spécifique, lis le doc correspondant :

| Sujet | Doc |
|---|---|
| Layered architecture, naming, exemple bout en bout | [architecture.md](.claude/standards/architecture.md) |
| Patterns Riverpod (provider types, optimistic updates, anti-patterns) | [state-management.md](.claude/standards/state-management.md) |
| Repository pattern, DTOs, mapping d'erreurs, RLS checklist | [supabase.md](.claude/standards/supabase.md) |
| Secrets, logging safe, validation, build release | [security.md](.claude/standards/security.md) |
| Structure des tests, mocktail, helpers, couverture | [testing.md](.claude/standards/testing.md) |

## Sous-agents — `.claude/agents/`

- `feature-scaffolder` — scaffolde un nouveau `features/<name>/` complet
- `supabase-reviewer` — relit les migrations SQL (RLS, indexes, naming)
- `riverpod-reviewer` — relit `data/` et `application/` contre les règles

## Slash commands — `.claude/commands/`

- `/new-feature <name>` — délègue au feature-scaffolder
- `/codegen` — `build_runner build` one-shot
- `/codegen-watch` — `build_runner watch` en background
- `/check` — `flutter analyze` + `flutter test`
- `/run` — `flutter run` avec `--dart-define-from-file=.env` automatique

## Notes importantes

- **Bundle ID** : `com.aevon.repster` (Android `applicationId` + `namespace`, iOS `PRODUCT_BUNDLE_IDENTIFIER`).
- **iOS minimum** : 13.0. **Android minSdk** : valeur par défaut Flutter (à bumper si un package l'exige).
- **Android cmdline-tools manquant** côté env local (`flutter doctor`) — n'empêche pas le build mais à régler avant signing release.
- Le `Supabase.initialize` doit être awaité avant `runApp` — déjà en place dans `main.dart`.
