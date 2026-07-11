# State management — Riverpod

Stack : `flutter_riverpod 2.6`, providers **manuels** (pas de codegen).

## Quel type de provider pour quoi

| Besoin | Provider | Notes |
|---|---|---|
| Injection (repository, client) | `Provider<T>` | Toujours `autoDispose: false` par défaut |
| Lecture pure, one-shot | `FutureProvider<T>` | `autoDispose` par défaut |
| Lecture streamée (auth state, realtime) | `StreamProvider<T>` | Idem |
| Lecture + mutations + cache | `AsyncNotifierProvider` | Le 90 % des features |
| État sync en mémoire (live session) | `NotifierProvider` | Sync only |

## Patterns non-négociables

### 1. Jamais de Supabase hors `data/`

❌
```dart
// presentation/something_screen.dart
final user = await Supabase.instance.client.auth.getUser();
```

✅
```dart
// application/auth_controller.dart appelle data/auth_repository.dart
// presentation watch un provider
final user = ref.watch(currentUserProvider);
```

### 2. UI watch `AsyncValue`, n'attend jamais une Future directement

❌
```dart
FutureBuilder(future: repo.fetch(), …)
```

✅
```dart
final state = ref.watch(myControllerProvider); // AsyncValue<T>
return AsyncValueWidget(value: state, data: (data) => …);
```

### 3. Mutations sur le `.notifier`, jamais sur le state directement

```dart
onPressed: () => ref.read(templatesControllerProvider.notifier).create(t),
```

### 4. Optimistic updates avec rollback

```dart
Future<void> delete(String id) async {
  final previous = state.valueOrNull ?? [];
  state = AsyncData(previous.where((t) => t.id != id).toList()); // optimistic
  try {
    await ref.read(templatesRepositoryProvider).delete(id);
  } catch (e, st) {
    state = AsyncData(previous); // rollback
    state = AsyncError(e, st);    // signal l'erreur
  }
}
```

### 5. Invalidation explicite après mutation cross-feature

```dart
await ref.read(sessionRepositoryProvider).save(session);
ref.invalidate(sessionHistoryProvider); // force le refetch
```

### 6. `autoDispose` par défaut

`FutureProvider` et `AsyncNotifierProvider` ont `autoDispose` par défaut depuis Riverpod 2.x. C'est ce qu'on veut — l'état d'une page est libéré quand on la quitte.

**Exceptions** (provider explicitement non-disposed) :
- `supabaseClientProvider` — singleton
- `authStateChangesProvider` — survit à la nav
- `liveSessionControllerProvider` — vit le temps de la séance, disposé quand on quitte l'écran session

### 7. Session live = `Notifier` synchrone

L'équivalent du Zustand store de la PWA. Tout est en mémoire pendant la séance ; flush vers Supabase **à la fin**, pas en cours.

```dart
class LiveSessionController extends Notifier<LiveSessionState> {
  @override
  LiveSessionState build() => LiveSessionState.initial();

  void recordSet(SetEntry entry) {
    state = state.copyWith(sets: [...state.sets, entry]);
  }

  Future<void> finish() async {
    await ref.read(sessionsRepositoryProvider).persist(state);
    ref.invalidate(sessionHistoryProvider);
  }
}
```

## Anti-patterns

- ❌ `ref.read` dans `build()` d'un widget (sauf callbacks)
- ❌ `ref.watch` dans un callback (`onPressed`, `onTap`…) — utiliser `ref.read`
- ❌ Mélanger `setState` et Riverpod sur le même état
- ❌ Stocker des Futures dans le state d'un Notifier
- ❌ `StateProvider` pour autre chose qu'un truc trivial (toggle, filtre local)
