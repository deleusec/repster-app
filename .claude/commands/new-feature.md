---
description: Scaffold a new feature folder under lib/features/<name>/ following the 4-layer architecture
---

The user invoked `/new-feature <name>` to create a new feature.

Parse the feature name from the argument (kebab-case or snake_case, e.g. `exercises`, `workout-history`). Normalize to `snake_case` for folder/file names.

Then delegate the work to the `feature-scaffolder` sub-agent via the Agent tool:

```
Agent(
  subagent_type: "feature-scaffolder",
  description: "Scaffold feature <name>",
  prompt: "Scaffold a new feature named '<name>' under lib/features/<name>/. Follow Repster's 4-layer architecture (data/domain/application/presentation). Read .claude/standards/architecture.md first. Ask the user whether this feature needs Supabase backing before creating data/ files. After scaffolding, run `flutter analyze` and report any issues."
)
```

If no name was provided, ask the user for it before delegating.
