# Architecture — Repster

## Les 4 couches par feature

Chaque feature sous `lib/features/<name>/` suit cette structure :

```
features/<name>/
├── data/            # Tout ce qui parle à Supabase
├── domain/          # Modèles purs (Freezed), aucune dépendance Flutter ni Supabase
├── application/     # Notifiers Riverpod — orchestrent data + domain
└── presentation/    # Écrans Flutter — bind des providers via ref.watch
```

### Règles de dépendances (strictes)

| Couche | Peut importer | Ne doit jamais importer |
|---|---|---|
| `domain/` | Dart pur, freezed_annotation | Flutter, Supabase, Riverpod |
| `data/` | `domain/`, `core/`, supabase_flutter, riverpod¹ | Flutter widgets, `application/`, `presentation/` |
| `application/` | `domain/`, `data/`, `core/`, riverpod | Flutter widgets, Supabase direct |
| `presentation/` | `domain/`, `application/`, `shared/`, Flutter | `data/` directement |

> ¹ **Riverpod dans `data/` — usage restreint.** Un repository est une classe Dart pure (constructeur prenant `SupabaseClient`, aucune dépendance Riverpod dans sa logique). La **seule** utilisation autorisée de Riverpod dans un fichier `data/` est de co-localiser en fin de fichier le `Provider` de DI du repository (ex. `templatesRepositoryProvider`, cf. exemple plus bas) et, si besoin, un `StreamProvider`/`FutureProvider` qui ne fait que déléguer au repo. Interdits : `Notifier`, `ref.watch` d'un état applicatif, ou toute logique métier — ça vit dans `application/`.

**Test de l'isolation** :
- Dans n'importe quel `presentation/*.dart` : `grep -r 'supabase\|from(' .` → 0 résultat.
- Dans n'importe quel `application/*.dart` : `grep -r 'package:supabase' .` → 0 résultat.
- Dans n'importe quel `data/*.dart` : `grep -r 'package:flutter/material\|/application/\|/presentation/' .` → 0 résultat.
- Dans n'importe quel `domain/*.dart` : `grep -r 'package:flutter\|package:supabase\|riverpod' .` → 0 résultat.

## Exemple bout en bout — créer un template

### 1. `domain/template.dart`
```dart
@freezed
class Template with _$Template {
  const factory Template({
    required String id,
    required String name,
    required List<Exercise> exercises,
  }) = _Template;
}
```

### 2. `data/template_dto.dart` (mapping)
```dart
class TemplateDto {
  static Template fromJson(Map<String, dynamic> json) => Template(
    id: json['id'] as String,
    name: json['name'] as String,
    exercises: (json['exercises'] as List).map(ExerciseDto.fromJson).toList(),
  );

  static Map<String, dynamic> toInsert(Template t) => {
    'name': t.name,
    // jamais d'id — Supabase le génère
  };
}
```

### 3. `data/templates_repository.dart`
```dart
class TemplatesRepository {
  TemplatesRepository(this._client);
  final SupabaseClient _client;

  Future<List<Template>> list() async {
    try {
      final rows = await _client.from('workout_templates').select();
      return rows.map(TemplateDto.fromJson).toList();
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }

  Future<Template> create(Template t) async {
    try {
      final row = await _client
          .from('workout_templates')
          .insert(TemplateDto.toInsert(t))
          .select()
          .single();
      return TemplateDto.fromJson(row);
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }
}

final templatesRepositoryProvider = Provider<TemplatesRepository>((ref) {
  return TemplatesRepository(ref.watch(supabaseClientProvider));
});
```

### 4. `application/templates_controller.dart`
```dart
class TemplatesController extends AsyncNotifier<List<Template>> {
  @override
  Future<List<Template>> build() => ref.read(templatesRepositoryProvider).list();

  Future<void> create(Template t) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final saved = await ref.read(templatesRepositoryProvider).create(t);
      return [...(state.valueOrNull ?? []), saved];
    });
  }
}

final templatesControllerProvider =
    AsyncNotifierProvider<TemplatesController, List<Template>>(
  TemplatesController.new,
);
```

### 5. `presentation/templates_list_screen.dart`
```dart
class TemplatesListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(templatesControllerProvider);
    return AsyncValueWidget<List<Template>>(
      value: state,
      onRetry: () => ref.invalidate(templatesControllerProvider),
      data: (templates) => ListView(/* … */),
    );
  }
}
```

## Conventions de nommage

- Fichiers : `snake_case.dart`
- Classes : `PascalCase`
- Providers : `<thing>Provider` en `camelCase` (ex: `templatesRepositoryProvider`)
- Controllers : `<Feature>Controller` (suffixe `Controller`, pas `Notifier`/`Bloc`)
- Repositories : `<Feature>Repository`
- DTOs : `<Feature>Dto`, méthodes statiques `fromJson`/`toInsert`/`toUpdate`
