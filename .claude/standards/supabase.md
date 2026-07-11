# Supabase — patterns et règles

## Repository pattern

Chaque table accédée par l'app a **un** repository dans `data/`. Aucune autre couche n'appelle `supabase.from(...)`.

### Squelette type

```dart
class TemplatesRepository {
  TemplatesRepository(this._client);
  final SupabaseClient _client;

  Future<List<Template>> list() async {
    try {
      final rows = await _client
          .from('workout_templates')
          .select('*, exercises:template_exercises(*)')
          .order('created_at', ascending: false);
      return rows.map(TemplateDto.fromJson).toList();
    } catch (e, st) {
      throw mapSupabaseError(e, st);
    }
  }
}
```

**Toujours :**
- `try/catch` autour de chaque appel Supabase
- `throw mapSupabaseError(e, st)` pour convertir en `AppException`
- Mapping via `XxxDto.fromJson` (centralisé, jamais inline)
- Pas de `.maybeSingle()` muet — préférer `.single()` qui lève → géré par `mapSupabaseError` en `NotFoundException`

## DTOs

Le DTO traduit Supabase ↔ domain. Il vit dans `data/`, importe `domain/`.

```dart
class TemplateDto {
  // Lecture
  static Template fromJson(Map<String, dynamic> json) => Template(/* … */);

  // Insertion (pas d'id, pas de timestamps)
  static Map<String, dynamic> toInsert(Template t) => {
    'name': t.name,
    'user_id': /* injecté par RLS via auth.uid() */,
  };

  // Update (champs modifiables uniquement)
  static Map<String, dynamic> toUpdate(Template t) => {
    'name': t.name,
  };
}
```

**Règles :**
- Jamais de `Template.fromJson` dans le modèle `domain/` — sinon le domain dépend implicitement du schéma Supabase.
- Le DTO **n'invente pas** : tous les champs viennent de Supabase, sauf ID et timestamps que la DB génère.

## Conversion d'erreurs

Toujours via `mapSupabaseError(e, st)` (dans `core/supabase/postgrest_error_x.dart`).

Mapping actuel :

| Source | Cible |
|---|---|
| `PostgrestException(code: 'PGRST116')` | `NotFoundException` |
| Autre `PostgrestException` | `UnexpectedException` (avec cause) |
| `AuthException` (Supabase) | `AppAuthException` (avec `reason` enum) |
| `SocketException` | `NetworkException` |
| Autre | `UnexpectedException` |

Ajouter un cas → modifier `mapSupabaseError` et documenter ici.

## RLS — Row Level Security

**Règle d'or** : toute table accédée par l'app a RLS activée + au moins une policy. Sans exception.

### Checklist par nouvelle table

- [ ] `ALTER TABLE x ENABLE ROW LEVEL SECURITY;`
- [ ] Policy SELECT : `auth.uid() = user_id`
- [ ] Policy INSERT : `WITH CHECK (auth.uid() = user_id)`
- [ ] Policy UPDATE : `USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id)`
- [ ] Policy DELETE : `USING (auth.uid() = user_id)`
- [ ] Index sur `user_id` (sinon les policies coûtent cher)
- [ ] Index sur les colonnes filtrées fréquemment côté app

### Conséquence côté app

- Une query retournant 0 row n'est **probablement pas** un bug de loading — c'est sans doute la RLS. Logger en `warn`.
- `auth.uid()` est implicitement filtré côté serveur. L'app ne doit **jamais** `WHERE user_id = ?` côté client (redondant + révèle l'attente).

## Realtime

Si on utilise les subscriptions :
- Wrap dans un `StreamProvider` dans `data/`.
- Dispose explicite (le `autoDispose` Riverpod s'en occupe).
- Convertir les erreurs du stream via `mapSupabaseError`.

## Anti-patterns

- ❌ `supabase.from()` ailleurs que dans `data/`
- ❌ `Map<String, dynamic>` qui remonte au-delà de `data/`
- ❌ Désactiver RLS « le temps de tester »
- ❌ Stocker la `service_role` key côté app
- ❌ Catch sans rethrow — toute erreur Supabase doit devenir une `AppException`
