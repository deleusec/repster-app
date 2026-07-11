---
description: Run the Flutter app with the required --dart-define-from-file=.env flag
---

The user wants to run the app. **Always include** `--dart-define-from-file=.env` — without it, `Env.assertConfigured()` throws at startup.

If the user passed a target device in the args (e.g. `chrome`, `linux`, device id), use it. Otherwise default to the first connected device.

Suggested commands depending on context:

```bash
# Run on default device
flutter run --dart-define-from-file=.env

# Run on Chrome
flutter run -d chrome --dart-define-from-file=.env

# Run release mode
flutter run --release --dart-define-from-file=.env
```

Use `run_in_background: true` since `flutter run` is long-running. Tell the user the background task ID and how to stop it.

Before launching, do a quick check:
- `.env` exists? If not, point to `.env.example` and stop.
- `SUPABASE_URL` and `SUPABASE_ANON_KEY` set in `.env`? If empty, warn the user.
