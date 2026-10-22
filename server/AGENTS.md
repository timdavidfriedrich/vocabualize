# Vocabualize backend

Serverpod `4.1.0-beta.3` with the experimental `serverpod_offline_sync` `0.0.11` module. The plan lives at `~/.claude-personal/plans/cosmic-munching-deer.md`; the sync spike's rules are in `../docs/spike_serverpod_sync.md`.

## Layout

```
server/
├── pubspec.yaml            pub workspace root for the server side only
└── vocabualize_server/     the backend

packages/vocabualize_client/    generated client, member of the app workspace
```

The generated client resolves with the Flutter app, and the server keeps its own workspace, so its dependency tree stays out of the app's resolution. The output path is `client_package_path` in `config/generator.yaml`.

## Rules

- **Code layers:**
  - `endpoints/` is transport only: auth check, argument validation, delegation.
  - `domain/` holds the rules.
  - `adapters/` has one folder per external system, each an interface plus implementations.
  - `composition.dart` is the only place that names concrete classes.
- **Configuration:**
  - Tunable values live in `app_config.yaml`. It is mounted into the container in production, served unauthenticated through `ConfigEndpoint`, and must never hold secrets.
  - Secrets live in `config/passwords.yaml`, which is gitignored. The local file holds `development:` only; production's is written on the VPS.
- **Synced tables** (`database: sync`):
  - Updates are always column-scoped (`updateRow(..., columns:)`).
  - Any schema change breaks sync for clients on the old schema until they update, so changes are rare, ship together with an app release, and only add nullable columns.
- **Generated code is never edited:** that covers `lib/src/generated/` and all of `packages/vocabualize_client`. A generated `migration.sql` may be hand-edited only to avoid data loss.

## Commands

The globally installed Serverpod CLI is another version, which `../book_marker` still needs. Always use the pinned dev dependency from `vocabualize_server/`:

- `fvm dart run serverpod_cli --no-analytics generate`
- `fvm dart run serverpod_cli --no-analytics create-migration`
- `fvm dart run serverpod_cli --no-analytics database start -s .` starts the embedded Postgres on port 8190.
- `fvm dart run bin/main.dart --apply-migrations` serves the API on port 8180 and Insights on port 8181.

The app is run with `fvm flutter run` from the repository root, never with `serverpod start`.

## Checklist after changes

1. `fvm dart analyze`
2. `fvm dart format lib bin`
3. `create-migration` and apply it, if a model changed
