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
- The sync module rejects clocks more than 1 minute apart (`_maxDrift` in its `hlc.dart`); a phone that is ahead fails on the server, which only closes the stream. `ClockDataSource` compares the phone clock with `config.serverTime()` on start, resume, network back and after a failed sync. Only a server-confirmed drift closes the gate (`GateClockWrong`) or blocks a write (`requireWritableSession()`); when unsure, nothing is blocked. The monotonic reference is dropped whenever the app leaves the foreground, because Android's monotonic clock pauses during sleep.
- An immediate reconnect needs a fresh event (start, network back, app resumed) or a connection that has carried data. A connection that dies right after its handshake never reconnects in a loop.

## Loading and empty states
An empty state may only ever mean "there is no data".
1. **Data readiness gates the app.** `SyncRepository.watchDataReadiness()` is `DataReady`, `DataDownloading` or `DataUnavailable(reason)`. A signed-in device whose `user_<id>.json` metadata lacks `hasCompletedInitialSync` runs `syncOnce` before the continuous sync. The same file stores the account's name and email (for the account-switch prompt) and marks sign-outs, so a failed deletion is finished on the next start. The router shows `Loading` while it runs and `WaitForData` (offline, sign in again, update) when it can't finish; connectivity and resume events retry it. Local-only use is always ready.
2. **Screens read the local database only after the gate.** Their states are sealed `Loading | Loaded(data) | Failure`. Empty UI is built only from `Loaded` with empty data, never from a missing first result.
3. **Every loading state has an exit.** Local queries always emit; `syncOnce` and endpoint calls end in a result or an error within Serverpod's client timeouts (20 s connect, 40 s stream idle). Never add timers to end a spinner.

## Running

- Copy `dart_defines.example.json` to `dart_defines.json`. Set `API_BASE_URL` to `http://localhost:8180/` and `GOOGLE_SERVER_CLIENT_ID` to the web client ID.
- Start the local backend from `server/vocabualize_server` (see `server/AGENTS.md`).
- On each Android device or emulator, run `adb -s <device> reverse tcp:8180 tcp:8180` once per connection, so the device's `localhost:8180` reaches this Mac.
- Run with `fvm flutter run -d <device> --dart-define-from-file=dart_defines.json`.

## Commits

- **Format:** `[<FIX|FEATURE|ADD|REMOVE|CHANGE>] <one-liner>`, one thing per commit.
  - `FIX`: a bug was fixed. The one-liner describes the original error, e.g. `[FIX] the app could not save anything without an account`.
  - `FEATURE`: a completely new thing.
  - `ADD`: small additions.
  - `REMOVE`: removing something.
  - `CHANGE`: an existing feature changed, without being strictly added or removed.
- **Reading:** the message reads as one sentence. If the keyword works as its verb, the one-liner continues in lowercase: `[ADD] this one functionality to this existing feature`. If the keyword can't be part of the sentence, the one-liner starts in uppercase.
- **Author:** the repository owner alone. Never add co-author, session or "generated with" lines to commits or pull requests.
