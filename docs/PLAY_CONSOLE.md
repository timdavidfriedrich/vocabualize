# Play Console answers

Answers for the forms in Play Console, based on what the app does. Re-check them whenever data handling changes, together with the privacy policy.

## URLs

| Field | Value |
|---|---|
| Privacy policy | https://vocabualize.timdavidfriedrich.de/privacy/ |
| Account deletion | https://vocabualize.timdavidfriedrich.de/delete-account/ |
| Website | https://vocabualize.timdavidfriedrich.de/ |

The site needs the Cloudflare DNS record for `vocabualize` first.

## App access

All functionality is available without special access: the app works without an account. Syncing needs Google sign-in, which reviewers can do with any Google account.

## Ads

No ads.

## Target audience

13 and over. The app is not designed for children, so it stays outside the Families policy.

## Content rating (IARC)

Category: reference, news or educational. Answer **no** to violence, sexual content, language, controlled substances, gambling, horror and user interaction or sharing between users. The app has no chat, no sharing between users and no purchases. Expected rating: Everyone / PEGI 3.

## Generative AI

Declare that the app uses generative AI: Gemini suggests words for a scanned photo. Users can report a suggestion in the app (Scan → "Report a suggestion", which opens Feedback & bugs).

## Data safety

General:
- Collects or shares user data: **yes**.
- Encrypted in transit: **yes** (HTTPS only).
- Users can request deletion: **yes** (in the app, and the deletion URL above).
- Data sent to DeepL, Pexels and Google Gemini is processing by **service providers** on our behalf, which Play does not count as sharing. So: **collected, not shared**.

| Play data type | Collected | Optional | Purposes | What it is |
|---|---|---|---|---|
| Personal info → Name | yes | yes | Account management | From Google sign-in |
| Personal info → Email address | yes | yes | Account management | From Google sign-in |
| Personal info → User IDs | yes | yes | Account management, App functionality | Account ID and Google account ID |
| Photos and videos → Photos | yes | yes | App functionality | Your photos, synced when signed in; a downscaled copy for Scan |
| App activity → Other user-generated content | yes | yes | App functionality, Customer support | Words and translations (synced, translated, searched), feedback messages |
| App activity → Other actions | yes | yes | App functionality | Activity days and answer counts for streaks, synced when signed in |
| Device or other IDs | yes | yes | App functionality, Fraud prevention, security and compliance | Random install key for anonymous limits, random device ID for activity rows |
| App info and performance → Other app performance data | yes | yes | Customer support | App and Android version sent with feedback |

Not collected: location (photo metadata is removed, and IP addresses are only stored as keyed hashes to rate-limit, not to locate), contacts, financial info, health, messages, audio, files, calendar, web browsing, crash logs, diagnostics, advertising IDs.

Judgement call: IP addresses. They reach our server and Cloudflare, but are only kept as keyed hashes for rate limiting and never used for location. Common practice is to not declare approximate location in that case.
