# Releasing the Android app

Releases go through GitHub Actions and fastlane.

## How a release works

- **Every push to `main`** (except server, website and docs changes) runs `build & release`. It analyzes the app and builds a signed AAB and APK, both available as a workflow download.
- **An upload to Google Play** happens when a commit since the last `v*` tag starts with a track prefix:

  | Prefix | Track |
  |---|---|
  | `[INTERNAL]` | internal testing (`internal`) |
  | `[ALPHA]` | closed testing (`alpha`) |
  | `[BETA]` | open testing (`beta`) |

  Example: `[ALPHA] first closed test with offline use and search`. With several prefixes since the last tag, the newest commit wins. The workflow then:
  1. uploads the AAB, the store texts and the changelog to that track and sends it to Google's review; after the review, testers get it on their own;
  2. archives the changelog;
  3. tags the commit and creates a GitHub pre-release with the AAB and APK.

  Two cases fall back on their own and need one click in Play Console. Until the app has been published once, Google only accepts drafts: start the rollout under the track. When Play Console has other changes waiting for review: click **Send for review** on the Publishing overview. The run's log says which one happened.

  If the upload fails, there is no tag, so the next push to `main` tries again.
- **Version:** the version in `pubspec.yaml` while it is newer than the last tag, otherwise the last tag with a patch bump. For a new minor or major version, raise it in `pubspec.yaml`. `-test` tags are ignored.
- **versionCode** is the commit count of `main`, so it always increases.
- **Production** is never a commit. Test the build, then run **promote** in the Actions tab with the versionCode, the track it is on and the target track. It goes to review the same way.

Run `bash scripts/bump-version.sh` locally to see what the next push would do.

### Changelogs

`fastlane/metadata/android/<locale>/changelogs/next.txt` is the text for the next upload. The upload copies it to `<versionCode>.txt` and empties it; with an empty `next.txt`, `default.txt` is used. Keep each one under 500 characters, in all five languages.

## One-time setup

### 1. Upload key

The upload key is `vocabualize_upload_keystore.jks` in the repo root, ignored by git. Google confirmed the upload key reset, so Play accepts builds signed with it.

For local release builds, create `android/key.properties` (ignored by git):

```properties
storeFile=../../vocabualize_upload_keystore.jks
storePassword=…
keyAlias=…
keyPassword=…
```

### 2. Play service account

fastlane talks to Google Play with a service account: a Google account for programs, with its own email and a JSON key instead of a password. It is not one of the OAuth client IDs (those are for Google sign-in) and not the upload key (that signs the AAB).

1. Google Cloud console, in the same project as the OAuth clients: APIs & Services → Library → enable **Google Play Android Developer API**.
2. IAM & Admin → Service accounts → **Create service account**, for example `play-upload`. It needs no Cloud roles.
3. Open it → Keys → Add key → Create new key → **JSON**. Save it as `fastlane/play-store-key.json` (ignored by git).
4. Play Console → Users and permissions → **Invite new users** → the service account's email → App permissions → Vocabualize with: release to testing tracks, release to production, manage testing tracks, edit store listing.
5. Check it: `bundle exec fastlane run validate_play_store_json_key json_key:fastlane/play-store-key.json`. A new account can take a few hours before Play accepts it.

### 3. GitHub secrets

Run these in the repo root. They read the values from the local files, so nothing lands in your shell history:

```bash
base64 -i vocabualize_upload_keystore.jks | gh secret set ANDROID_KEYSTORE_BASE64
sed -n 's/^storePassword=//p' android/key.properties | tr -d '\r\n' | gh secret set ANDROID_KEYSTORE_PASSWORD
sed -n 's/^keyAlias=//p' android/key.properties | tr -d '\r\n' | gh secret set ANDROID_KEY_ALIAS
sed -n 's/^keyPassword=//p' android/key.properties | tr -d '\r\n' | gh secret set ANDROID_KEY_PASSWORD
gh secret set DART_DEFINES_PRODUCTION < dart_defines.production.json
gh secret set GOOGLE_PLAY_JSON_KEY < fastlane/play-store-key.json
```

Without these secrets, pushes still build (debug-signed, with `dart_defines.example.json`) as a compile check, but an upload fails with a clear message.

### 4. Play Console

- See `docs/PLAY_CONSOLE.md` for the answers to paste: privacy policy and deletion URLs, data safety, content rating, app access and the AI declaration.
- Each testing track needs testers (email list or Google Group) and countries before its first rollout.

### 5. Google sign-in for Play builds

Google Play re-signs every build with its own app signing key, so builds from the Play Store have a different SHA-1 than local builds. Without an Android OAuth client for that SHA-1, the account picker closes and nothing happens.

1. Play Console → Test and release → App integrity → App signing: copy the SHA-1 of the **app signing key certificate**.
2. Google Cloud console, in the project of `GOOGLE_SERVER_CLIENT_ID`: Credentials → Create credentials → OAuth client ID → **Android**, package `de.timdavidfriedrich.vocabualize` and that SHA-1.

Keep one Android client per key: debug, upload key and Play app signing key.

## Before each release

- Update the privacy policy (`website/public`) in both languages if data handling changed: new data, a new service, or different retention.
- Deploy the server first if the app needs new endpoints, and on the same day for synced-table changes (see `CLAUDE.md`).
