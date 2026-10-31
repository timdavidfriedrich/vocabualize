# Spike: Serverpod 4.1 offline sync

**Decision: go.** The sync module works for this app, with five rules (below) that the data layer must follow. The fallback (drift plus an own sync) is not needed.

- **Setup:** Serverpod `4.1.0-beta.3` with `serverpod_offline_sync` `0.0.11`, embedded Postgres, a demo token handler instead of a real identity provider.
- **Where:** the code is on branch `spike/serverpod-sync`, in `spike/`. `spike_client/bin/merge_check.dart` replays two replicas against one account; `spike_flutter` measures on Android. Date: 2026-10-21.
- **Data:** synced tables `SpikeWord` (word + spaced-repetition fields), `SpikeTag`, and the `SpikeWordTag` join with cascading deferred foreign keys.

## Results

### Correctness (two replicas, same account)

| Check | Result |
|---|---|
| String with emoji, double, bool, DateTime round trip | Pass. DateTime arrives with **millisecond** precision; microseconds are dropped |
| Concurrent edits to different fields, full-row `updateRow` | **Edit lost.** A full-row update writes every column with a new timestamp, so the later device's stale copy of the other field wins |
| Concurrent edits to different fields, `updateRow(..., columns:)` | Pass. Both edits survive |
| Same field edited on both devices | Pass. The later write wins on both |
| Re-writing a row with unchanged values | New field timestamps are written (confirms the full-row problem) |
| Delete vs a concurrent edit | Pass. Both converge to deleted |
| Deleting a tag | Pass. The join rows cascade on both devices; the word stays |
| Write offline, then sync | Pass. The pending row arrives after reconnect |
| `syncOnce` while the server is unreachable | Throws within about 30 ms. A 401 throws too, so `syncOnce` works as the sign-out barrier |
| Re-insert a deleted id; insert a non-v7 UUID | Both accepted |
| Local-only session (random `persistentUserId`, never known to the server) | Works fully offline |
| Syncing that local-only space while signed in as a real user | Returns normally but transfers nothing. Adoption therefore has to copy rows into the user's database |
| Close, reopen, delete the database file | Pass |
| Old client after a column is **added to a synced table** | **Every sync fails** with `OfflineSyncTablesHashMismatchException` until the app is updated. Local data is kept |
| Old client after a **server-only** table is added | Pass. Server-only tables can change freely |

### Performance (Android emulator, arm64, 16 KB pages)

5,000 words, 20 tags and 500 links.

| Operation | Profile | Release (R8) |
|---|---|---|
| Open database (first / reopen) | 2.0 s / 38 ms | 0.5 s / 23 ms |
| Insert 5,000 words in one call | 850 ms | – |
| Page of 50 ordered by `nextReviewAt` | 5–13 ms | 4–6 ms |
| `count()` all / due | 7–11 ms | 3–10 ms |
| `watch(limit: 50)` first emission | 2–4 ms | 1.5–3 ms |
| Load all 5,000 rows | 60–100 ms | 52–67 ms |
| Answer (one row update) → `watch` re-emits | 11–15 ms → 12–17 ms | – |
| Adopt 5,000 + 520 rows into a new database | 1.0 s | – |
| First push of 5,000 rows / first pull on a new device | 15.8 s / 17.0 s | 15.9 s pull |

The release build with R8 runs without missing classes, and the SQLite native libraries load on a 16 KB-page system image. The emulator runs on an M-series Mac, so a real mid-range phone will be slower.

## Rules for the data layer

1. **Every update is column-scoped.**
   - Repositories always pass `columns:`: an answer writes only the spaced-repetition columns, an edit writes only the edited fields.
   - A full-row `updateRow` is never used on synced tables.
2. **The synced schema is frozen before the first release.**
   - Each synced table gets one nullable `extras` JSON column for later, non-indexed attributes. It merges as a single field with last-writer-wins.
   - A real schema change means: server and app release on the same day; old clients map `OfflineSyncTablesHashMismatchException` to an "update to keep syncing" state, and the app keeps working offline.
3. **Never load all rows into the UI.** Lists use `watch` with `limit` and load more pages; numbers come from `count()`.
4. **The first sync shows progress.** A fresh device with 5,000 words needs about 17 s. The single migrated user has a few hundred words, which takes 1–2 s.
5. **Times are millisecond-precise.** Nothing may depend on sub-millisecond ordering.
6. **Relation filters need `isVisible`.**
   - A deleted synced row stays in its table; only its `crdt_data_rows.visibility` hides it.
   - Root queries and `include` lists add that check, but relation filters inside `where` (`any`, `none`, `count`, `every`) don't, so they match deleted rows.
   - Every condition inside a relation filter adds `.isVisible` from `packages/shared/lib/data/extensions/table_extensions.dart`, for example `t.progress.any((progress) => progress.isVisible & ...)`.

## Still open

- **Upload to Garage and download via a signed URL.** Needs Docker or the VPS; moved to phase 2.
- **Google sign-in and the anonymous AI identity.** Moved to phases 2 and 4.
- **A real mid-range Android device.** Repeat the profile scenario with `fvm flutter run --profile --dart-define=SCENARIO=perf`.
- **A pending-change count.** The module has no API for it. It isn't needed, because `syncOnce` success is the sign-out barrier.
