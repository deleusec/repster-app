---
description: Start build_runner in watch mode (background) for live freezed/json codegen
---

Launch `build_runner watch` in the background so the user can keep editing models without re-running codegen manually:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

Use the Bash tool with `run_in_background: true`. Confirm the watcher started, and tell the user how to stop it (kill the background task ID).

If a watcher is already running in this session, don't start a second one — point at the existing one instead.
