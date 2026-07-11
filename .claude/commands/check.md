---
description: Run flutter analyze + flutter test and summarize the result
---

Run these in parallel:

```bash
flutter analyze
flutter test
```

Summarize in this format:

```
✅ analyze: clean
✅ tests: 24 passed
```

Or if anything fails:

```
❌ analyze: 3 issues
  - lib/features/templates/data/templates_repository.dart:42: ...
  - ...

❌ tests: 2 failures
  - test/features/templates/.../templates_controller_test.dart
    Expected: ...
```

Keep it tight. Don't dump full output unless asked.
