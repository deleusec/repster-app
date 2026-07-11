---
description: Run build_runner once to regenerate freezed/json_serializable outputs
---

Run the following command and report the result:

```bash
dart run build_runner build --delete-conflicting-outputs
```

If it succeeds, just confirm "codegen OK" and how long it took. If it fails, summarize the error and suggest fixes (typically: a malformed `@freezed` annotation, a missing `part 'x.freezed.dart';` directive, or a type issue in a `fromJson`).
