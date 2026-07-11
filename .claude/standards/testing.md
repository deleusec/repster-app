# Testing — Repster

Stack : `flutter_test` + `mocktail`.

## Structure

Le dossier `test/` mirror exactement `lib/` :

```
test/
├── core/
│   └── supabase/postgrest_error_x_test.dart
├── features/
│   └── templates/
│       ├── data/templates_repository_test.dart
│       ├── application/templates_controller_test.dart
│       └── presentation/templates_list_screen_test.dart
├── helpers/
│   ├── pump_app.dart                       # Helper pour widget tests
│   ├── fakes.dart                          # Repos fake réutilisables
│   └── matchers.dart                       # Matchers customs
└── integration_test/                       # E2E (rare, smoke tests)
```

## Par couche

### `domain/` — tests unitaires purs

Modèles Freezed → tester `copyWith`, égalité, méthodes pures.

### `data/` — repository tests avec `Mock` Supabase

```dart
class _MockSupabase extends Mock implements SupabaseClient {}
class _MockQuery extends Mock implements SupabaseQueryBuilder {}

void main() {
  late _MockSupabase supabase;
  late TemplatesRepository repo;

  setUp(() {
    supabase = _MockSupabase();
    repo = TemplatesRepository(supabase);
  });

  test('list() maps rows to Template', () async {
    final query = _MockQuery();
    when(() => supabase.from('workout_templates')).thenReturn(query);
    when(() => query.select()).thenAnswer((_) async => [
      {'id': '1', 'name': 'PPL', 'exercises': []},
    ]);

    final templates = await repo.list();
    expect(templates, hasLength(1));
    expect(templates.first.name, 'PPL');
  });

  test('PGRST116 becomes NotFoundException', () async {
    when(() => supabase.from(any())).thenThrow(
      const PostgrestException(message: '', code: 'PGRST116'),
    );
    expect(() => repo.list(), throwsA(isA<NotFoundException>()));
  });
}
```

### `application/` — controller tests avec repo override

```dart
class _FakeRepo extends Fake implements TemplatesRepository {
  @override
  Future<List<Template>> list() async => [_fake];
}

void main() {
  test('initial state loads from repo', () async {
    final container = ProviderContainer(overrides: [
      templatesRepositoryProvider.overrideWithValue(_FakeRepo()),
    ]);
    addTearDown(container.dispose);

    final value = await container.read(templatesControllerProvider.future);
    expect(value, hasLength(1));
  });
}
```

### `presentation/` — widget tests via `pump_app`

```dart
testWidgets('shows templates list', (tester) async {
  await tester.pumpApp(
    const TemplatesListScreen(),
    overrides: [
      templatesRepositoryProvider.overrideWithValue(_FakeRepo()),
    ],
  );
  expect(find.text('PPL'), findsOneWidget);
});
```

### `pump_app` helper

```dart
extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget child, {
    List<Override> overrides = const [],
  }) {
    return pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(home: child),
      ),
    );
  }
}
```

## Anti-patterns

- ❌ Tester un widget en construisant un vrai `SupabaseClient` (network in tests = flaky)
- ❌ `pumpAndSettle` indéfini sur une UI qui re-anime (timeout) — utiliser `pump(Duration)` ciblé
- ❌ Tests qui dépendent de l'ordre d'exécution (état global non disposé)
- ❌ Skip d'un test cassé avec `skip: true` — soit on fix soit on supprime
- ❌ Mock de la couche `domain/` (modèles purs — pas de mock nécessaire)

## Couverture

Pas d'objectif absolu, mais focus sur :
- ✅ Tous les repositories (mapping + conversion d'erreurs)
- ✅ Toute logique métier dans `application/` (validations, optimistic updates)
- ✅ Smoke widget test par écran (au minimum : « se rend sans crash »)
- 🟡 Widget tests détaillés seulement pour les écrans à logique UI complexe

Commande locale : `flutter test --coverage` puis voir `coverage/lcov.info`.
