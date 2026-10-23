# Vocabualize

Before writing or editing any Dart file, invoke the `flutter-styleguide:styleguide` skill.

If that skill is not available, read the rules from
<https://github.com/timdavidfriedrich/flutter-workspace/tree/main/plugins/flutter-styleguide/skills/styleguide>
and follow them, starting with `SKILL.md`.

New feature package: `/flutter-styleguide:add-feature <name>` or `fsg add-feature <name>`.

The rewrite follows the plan at `~/.claude-personal/plans/cosmic-munching-deer.md`. The legacy app lives untouched at `../vocabualize_dev`; read it, never change it. The backend is in `server/` (see `server/AGENTS.md`).

## Deviations from the styleguide

These were decided on purpose; do not "fix" them:

1. **Serverpod models are the data-layer models.**
   - Generated classes from `packages/vocabualize_client` act as `Local*` (synced rows, `database: sync`) and `Remote*` (endpoint data) models instead of dart_mappable models.
   - Entities in `shared/domain/entities/` stay dart_mappable.
   - Mappers run only in repository implementations, and generated types never appear above repositories.
2. **Serverpod's client and `FileUploader` are the transport** for the API, sync and uploads. `dio` is only used for downloading images from signed URLs.
3. **Remote config is server data**, loaded through a repository from `ConfigEndpoint` (`server/vocabualize_server/app_config.yaml`). The rule in `logging.md` against reading configuration at runtime still applies to build configuration.
4. **`server/` is a separate pub workspace** outside the app workspace. Only the generated client is a member of the app workspace.
5. **`kaisel` replaces `go_router`** (routing.md). The setup follows `../book_marker`:
   - **Routes:** a sealed `AppRoute extends KaiselRoute` hierarchy in `shared/presentation/navigation/routes.dart`, instead of the `NavigationRoute` enum. A route with fields overrides `props`.
   - **Navigation:** typed navigation stays in `NavigationExtension` (`shared/presentation/navigation/navigation_extensions.dart`), for example `context.pushArticleDetail(articleId: id)`. Screens never build routes themselves.
   - **Composition:** `NavigationRouter` (`@lazySingleton`, `lib/src/navigation/navigation_router.dart`) owns the `KaiselRouterConfig`, and its exhaustive page switch is the only place that creates `BlocProvider`s for routes.
   - **Gating:** auth and app-status redirects are kaisel guards, or an app-status listener that calls `router.set(...)`. There is no refresh stream.

## Rules from the sync spike

The spike's findings are in `docs/spike_serverpod_sync.md` and are binding for the data layer:

- Updates to synced rows are always column-scoped (`updateRow(..., columns:)`).
- The synced schema is frozen before release. A synced-table change breaks sync for older clients until they update.
- Lists read pages through `watch(limit:)` and numbers come from `count()`. Never load every row into the UI.

## Running

- Copy `dart_defines.example.json` to `dart_defines.json` and set `API_BASE_URL` (`http://10.0.2.2:8180/` reaches a local server from the Android emulator).
- Run with `fvm flutter run --dart-define-from-file=dart_defines.json`.
