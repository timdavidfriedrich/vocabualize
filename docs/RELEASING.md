# Releasing the Android app

Releases go through GitHub Actions and fastlane, the same setup as schnopsn.

## How a release works

- **Every push to `main`** (except server, website and docs changes) runs `build & release`. It analyzes the app and builds a signed AAB and APK, both available as a workflow download.
- **A release** happens when a commit since the last `v*` tag contains `[RELEASE]` (minor bump) or `[PATCH]` / `[HOTFIX]` (patch bump). The workflow then:
  1. uploads the AAB and the store texts from `fastlane/metadata/android/` to the **internal** track, as a draft;
  2. archives the changelog;
  3. creates the GitHub release with the AAB and APK.

  The first release uses the version in `pubspec.yaml` (`1.0.0`). Later releases bump from the last tag. `-test` tags are ignored.
- **versionCode** is the commit count of `main`, so it always increases.
- **To production:** test the internal build, then run **promote to production** in the Actions tab with the versionCode shown in the release run.

Run `bash scripts/bump-version.sh` locally to see what the next push would do.

### Changelogs

`fastlane/metadata/android/<locale>/changelogs/next.txt` is the text for the next release. The release copies it to `<versionCode>.txt` and empties it; with an empty `next.txt`, `default.txt` is used. Keep each one under 500 characters, in all five languages.

## One-time setup

### 1. Upload key

Google has to approve the upload key reset first; it usually takes about 2 days after the request. Builds signed with the new key are rejected until then. The new keystore is `vocabualize_upload_keystore.jks` in the repo root, ignored by git.

For local release builds, create `android/key.properties` (ignored by git):

```properties
storeFile=../../vocabualize_upload_keystore.jks
storePassword=…
keyAlias=…
keyPassword=…
```

### 2. Play service account

1. Google Cloud console: in a project, enable the **Google Play Android Developer API**.
2. Create a service account and download a **JSON key**.
3. Play Console → Users and permissions → invite the service account's email with release permissions for Vocabualize.

### 3. GitHub secrets

Run these in a terminal in the repo root. The interactive ones prompt for the value, so it never lands in your shell history:

```bash
base64 -i vocabualize_upload_keystore.jks | gh secret set ANDROID_KEYSTORE_BASE64
gh secret set ANDROID_KEYSTORE_PASSWORD
gh secret set ANDROID_KEY_ALIAS
gh secret set ANDROID_KEY_PASSWORD
gh secret set DART_DEFINES_PRODUCTION < dart_defines.production.json
gh secret set GOOGLE_PLAY_JSON_KEY < path/to/service-account.json
```

Without these secrets, pushes still build (debug-signed, with `dart_defines.example.json`) as a compile check, but a release fails with a clear message.

### 4. Play Console

See `docs/PLAY_CONSOLE.md` for the answers to paste: privacy policy and deletion URLs, data safety, content rating, app access and the AI declaration.

## Before each release

- Update the privacy policy (`website/public`) in both languages if data handling changed: new data, a new service, or different retention.
- Deploy the server first if the app needs new endpoints, and on the same day for synced-table changes (see `CLAUDE.md`).
