# Legacy parity check

Compares the legacy app (`../vocabualize_dev`) with the new app, feature by feature, and tracks what has been verified.

## How every feature is checked

1. **Inventory from four legacy sources**, so nothing depends on memory:
   - 18 screens (`lib/src/**/presentation/screens`)
   - all public controller methods (what the user can trigger)
   - 62 use cases (behavior the UI doesn't show)
   - 136 English strings. Every legacy string was matched to the closest new string by text; legacy strings without a counterpart point to missing or dropped features.
2. **Each item gets a status:**
   - ✅ ported
   - 🔄 changed on purpose (decision noted)
   - ❓ changed, needs your decision
   - ❌ missing
   - 🗑 dropped on purpose
   - ➕ new
3. **Each item gets a verification level:**
   - **S**: checked in code
   - **E**: tested on the emulator
   - **P**: tested on your phone (from the progress notes)
4. **Design** is checked per screen, side by side with screenshots of both apps. The legacy app only runs against the old PocketBase, so this has to happen **before PocketBase is shut down**.
5. **Open items** go to the list at the end and are resolved one by one.

## Results (2026-10-27, static pass)

### Onboarding and welcome

| Legacy | New | Status | Verified |
|---|---|---|---|
| Sign in with Google | Sign in with Google | ✅ | P |
| Sign in with GitHub | none | 🗑 Google only (Apple with iOS) | S |
| Email sign-up, sign-in, verification, password reset | none | 🗑 Google only | S |
| Anonymous account (password = record ID) | "Continue without account", local only | 🔄 local-only mode, no server account | P |
| Thesis notes, accept, "keep data after test phase" | none | 🗑 thesis | S |
| Choose languages via a full-screen language picker | Language pair as chips (5 languages) | 🔄 bundled language list, chips instead of picker | P |
| Languages loaded from the server | Bundled constants | 🔄 by design | S |
| Note that the code is open source (GitHub) | none | ❓ see open item 4 | S |

### Home

| Legacy | New | Status | Verified |
|---|---|---|---|
| Title row: title, streak chip, settings | Same, plus sync status icon | ✅ ➕ | P |
| Streak chip (tap did nothing) | Streak chip opens the streak sheet | ✅ ➕ | P |
| Alerts from the server on Home | none yet | ⏳ "For later" (banners) | S |
| Status card: level counts, practice button with due badge | Same | ✅ | P |
| Status card message: random playful line ("You added your first word!", "Wow, you already added 5 words today", …) | Facts: due count, total, all done, next due time | ❓ see open item 1 | S |
| "Recently added" section | Same | ✅ | P |
| Collections row (only with the experimental toggle) | Always shown when collections exist | 🔄 see open item 2 | P |
| Word list: tap = info, swipe right = edit, swipe left = delete, read aloud | Same | ✅ | P |
| "+" menu: Scan, Write, Speak | Scan, Write | 🗑 Speak (voice input) later, by plan | P |
| Empty state with mascot | Same | ✅ | E |

### Details (add and edit)

| Legacy | New | Status | Verified |
|---|---|---|---|
| Edit source and target in dialogs, offer retranslation | Same | ✅ | P |
| Automatic translation | DeepL through the server, limits per tier | ✅ 🔄 | P |
| Stock photos: word translated to English, articles removed, then searched | Searched in the source language with Pexels' `locale` | 🔄 see open item 5 | P |
| Browse more stock photos | Same | ✅ | P |
| Own photo from camera or gallery | Same, resized, metadata removed | ✅ | P |
| Photographer link | Same | ✅ | P |
| Select or unselect an image | Same | ✅ | P |
| Add to collection, create collection | Same | ✅ | P |
| Duplicate check | Same, for Write and Scan | ✅ | P |
| Delete word | Same | ✅ | P |
| — | Report a faulty translation | ➕ | P |
| — | Offline notice with automatic retry | ➕ | P |

### Practice

| Legacy | New | Status | Verified |
|---|---|---|---|
| Card with image, show solution, rate (hard, good, easy, forgot) | Same | ✅ | P |
| Type-answer mode with diff | Same | ✅ | P |
| Read aloud | Same | ✅ | P |
| Language label when the queue mixes languages | Same | ✅ | S |
| Practice one collection | Same | ✅ | P |
| Spaced repetition rules | Rewritten with fixed rules | 🔄 by plan | P |
| Done screen | Same | ✅ | P |

### Scan (legacy "Record")

| Legacy | New | Status | Verified |
|---|---|---|---|
| Camera, switch lens, zoom, take photo, retake | Same | ✅ | E P |
| Labels from on-device TFLite models | Gemini through the server, limits per tier | 🔄 by plan | P |
| Type your own word | Same | ✅ | E |
| Duplicate check | Same | ✅ | S |
| Offline dialog | Inline notice with a button to connect | 🔄 | P |
| — | "Report a suggestion" (Play AI rule) | ➕ | S |

### Collections

| Legacy | New | Status | Verified |
|---|---|---|---|
| Collection screen with its words | Same | ✅ | P |
| Practice this collection | Same | ✅ | P |
| Edit collection (was a TODO) | Rename and delete | ➕ | P |

### Settings

| Legacy | New | Status | Verified |
|---|---|---|---|
| Sign in, sign out | Same, sign-out guarded until synced | ✅ | P |
| Link anonymous account to Google or GitHub | Sign in moves local data into the account (adoption) | 🔄 | P |
| Source and target language | Language pair | ✅ | P |
| Disable type-answer mode (experimental) | In "Learning" | ✅ | P |
| Hide images (experimental) | In "Learning", also hides Scan and stock photos | ✅ | P |
| Enable collections (experimental, off by default) | none, always on | ❓ see open item 2 | S |
| Experimental section, copy ID, survey, keep data, onboarding link | none | 🗑 thesis | S |
| Practice reminder with time | Same, only on days with due words | ✅ | P |
| "Gather words" reminder with time | Streak reminder, with "look around" messages | ❓ see open item 3 | S |
| Push notifications (Firebase) | none | 🗑 no telemetry or Firebase | S |
| Open notification settings | Same, plus a "blocked" hint | ✅ | P |
| Report bug | Feedback & bugs | ✅ | P |
| — | Backup export and import | ➕ | P |
| — | Delete account / delete all data | ➕ | P |
| — | Privacy policy link | ➕ | E |

### Shared screens and background behavior

| Legacy | New | Status | Verified |
|---|---|---|---|
| Blocking alert screen | Gate: maintenance and required update | ✅ | P |
| — | Gate: wrong phone clock | ➕ | P |
| Offline screen that blocks the app | none, the app works offline | 🗑 offline-first | P |
| Loading screen | Same, with progress for long imports | ✅ | P |
| Vocabulary info dialog | Same | ✅ | P |
| Usage tracking (3 collections) | none | 🗑 no telemetry | S |
| Streak counter on the server | Computed from activity days, freezes, sheet, reminder | 🔄 ➕ | P |

### Design

| Aspect | Status |
|---|---|
| Dark theme and color palette | ✅ same colors |
| Font Poppins | 🔄 bundled instead of downloaded at runtime (no Google Fonts request) |
| Text sizes | 🔄 Material defaults (decided during the Home port); legacy used custom sizes (e.g. body 16 instead of 14) |
| Button styles | ✅ legacy styles in the theme |
| Mascots and launcher icon | ✅ same artwork |
| Layout of Home, Details, Scan, Practice | ✅ ported 1:1 per the Phase 4 notes; side-by-side screenshots still to do |

## Open items

1. **Status card message:** bring back the playful rotating line? Suggestion: show it above the facts, and keep the facts.
2. **Collections toggle:** keep collections always on (recommended), or bring back the opt-in switch.
3. **"Gather words" reminder:** the streak reminder's "look around" messages cover it, but only while a streak exists. Keep it that way, or add a separate daily reminder.
4. **Open-source note:** add "Source code on GitHub" to Settings, or leave it out.
5. **Stock photo search language:** check results for a few German, Spanish and Polish words against the legacy approach (English search terms).
6. **Side-by-side screenshots** of all screens in both apps, before PocketBase is shut down.
7. **Device walkthrough** of every ✅ row still marked only S or E.
