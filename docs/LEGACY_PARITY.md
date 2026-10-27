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
4. **Design** is checked per screen, side by side with screenshots of both apps (done 2026-10-27, see "Side-by-side pass").
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
| Note that the code is open source (GitHub) | none | 🗑 decided: left out | S |

### Home

| Legacy | New | Status | Verified |
|---|---|---|---|
| Title row: title, streak chip, settings | Same, plus sync status icon | ✅ ➕ | P |
| Streak chip (tap did nothing) | Streak chip opens the streak sheet | ✅ ➕ | P |
| Alerts from the server on Home | none yet | ⏳ "For later" (banners) | S |
| Status card: level counts, practice button with due badge | Same | ✅ | P |
| Status card message: random playful line ("You added your first word!", "Wow, you already added 5 words today", …) | Same messages (one per day), with the due facts below | ✅ | E |
| "Recently added" section | Same | ✅ | P |
| Collections row (only with the experimental toggle) | Always shown when collections exist | 🔄 decided: always on | P |
| Word list: tap = info, swipe right = edit, swipe left = delete, read aloud | Same | ✅ | P |
| "+" menu: Scan, Write, Speak | Scan, Write | 🗑 Speak (voice input) later, by plan | P |
| Empty state with mascot | Same | ✅ | E |

### Details (add and edit)

| Legacy | New | Status | Verified |
|---|---|---|---|
| Edit source and target in dialogs, offer retranslation | Same | ✅ | P |
| Automatic translation | DeepL through the server, limits per tier | ✅ 🔄 | P |
| Stock photos: word translated to English, articles removed, then searched | Searched in the source language with Pexels' `locale` | 🔄 decided: keep | P |
| Browse more stock photos | Same | ✅ | P |
| Own photo from camera or gallery | Same, resized, metadata removed | ✅ | P |
| Photographer link | Same | ✅ | P |
| Select or unselect an image | Same | ✅ | P |
| Add to collection, create collection | Same | ✅ | P |
| Duplicate check | Same, for Write and Scan | ✅ | P |
| Delete word | Same | ✅ | P |
| Report a faulty translation (full screen, 128 characters) | Full-screen dialog with the word pair, 2,000 characters | ✅ | E |
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
| Enable collections (experimental, off by default) | none, always on | 🔄 decided: no switch | E |
| Experimental section, copy ID, survey, keep data, onboarding link | none | 🗑 thesis | E |
| Practice reminder, always on at 19:00 (the time picker existed only in debug builds) | Switch and time, off by default, only on days with due words | 🔄 | P |
| "Gather words" reminder, always on at 13:00 (time picker only in debug builds) | Streak reminder, with "look around" messages | 🔄 decided: no separate reminder for now | E |
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
| Button styles | ✅ shape, colors and the legacy 48 dp height; labels stay 14 bold (decided) |
| Slider and switches | ✅ 2024 slider like legacy; switches keep the new grey thumbs (decided) |
| Mascots and launcher icon | ✅ same artwork |
| Layout of Home, Details, Scan, Practice, Collections | ✅ matches in the side-by-side pass |
| Layout of Welcome and Settings | ✅ legacy design (Settings with the new rows as rounded rows) |
| Language choice | 🔄 new chips kept (decided), button at the bottom |

## Side-by-side pass (2026-10-27)

Both apps ran on the same emulator (Pixel 10 Pro) with the same eight words, photos and practice answers. Legacy ran as a test account without sign-in against the old PocketBase; the new app ran without an account against the local dev server. Legacy screenshots are kept in [`legacy_screenshots/`](legacy_screenshots/) because they cannot be taken again after the shutdown. The full comparison with notes per screen is a private page: https://claude.ai/artifact/UMEBLM1rgzzic21LznimkE

| Screen | Result |
|---|---|
| Splash, empty Home, word list, swipes, Write dialog, Details, stock photos, edit dialogs, collection chip, collection screen, done screen | Same |
| Home status card | One line taller (two facts instead of one message); content below sits about 9 dp lower |
| Practice, Details, dialogs | Same layout; every button label is smaller |
| Word info dialog | Date follows the phone locale (10/27/2026) instead of always 27.10.2026; kept, per the date guideline |
| Scan camera | Zoom slider in the old round style; legacy switched to the 2024 slider in its last commit |
| Scan labels | Legacy labeling fails now (no working Gemini key); new shows suggestions and "Report a suggestion" |
| Welcome | Different: legacy has a blue background, the standing mascot, white buttons with logos and a text link |
| Language choice | Different: legacy has "I speak" / "I want to learn", a tinted background and "Let's start!" at the bottom |
| Settings | Different: legacy has a left title with a Feedback button and ⋮ menu, a sign-in card, language pill buttons and a collapsible experimental section |
| Faulty translation | Different: legacy is a full screen with the word pair as header |
| Feedback / Report bug | Same structure; new adds an intro and the "Sent along" note |

Not captured: legacy "Speak" (opening it crashed the emulator), legacy type-answer mode (it only shows for words past the novice steps), the maintenance gate.

## Open items

1. **Device walkthrough** of every ✅ row still marked only S or E.
2. **Signed-in Settings card** (avatar, sync status, sign-out): built, not yet seen on a device, because the emulator has no Google account.

## Decided (2026-10-27)

- Playful status line: yes, above the due facts; the card grows with the text.
- Collections: always on, no switch.
- "Gather words" reminder: none for now.
- Open-source note: left out.
- Stock photo search: keeps the source language.
- Design: legacy Welcome (without GitHub) and Settings; the new language chips stay with the button at the bottom; reports are full-screen dialogs with the button at the bottom; buttons 48 dp with the current text size; 2024 slider; switches unchanged.
