#!/usr/bin/env bash
set -euo pipefail

# Every push to main builds the app. An upload to Google Play only happens when
# a commit since the last release tag starts with a track prefix:
# [INTERNAL] -> internal, [ALPHA] -> alpha (closed testing), [BETA] -> beta
# (open testing). With several, the newest commit wins. Production is never a
# commit, it is the "promote" workflow.
#
# The version is the one in pubspec.yaml while it is newer than the last tag,
# otherwise the last tag with a patch bump. The first release uses pubspec.yaml
# as is. versionCode is the commit count on the branch, so every build gets a
# unique, increasing code.
#
# Writes version_name, version_code, tag, track and should_upload to
# $GITHUB_OUTPUT (or stdout when run locally) and the release notes to
# release-notes.md.

pubspec_version=$(sed -n 's/^version:[[:space:]]*\([0-9][0-9.]*\).*/\1/p' pubspec.yaml)
last_tag=$(git describe --tags --abbrev=0 --match 'v[0-9]*' --exclude '*-*' 2>/dev/null || true)

if [[ -n "$last_tag" ]]; then
    range="${last_tag}..HEAD"
    IFS='.' read -r major minor patch <<< "${last_tag#v}"
    bumped="${major:-0}.${minor:-0}.$((${patch:-0} + 1))"
    version_name=$(printf '%s\n%s\n' "$pubspec_version" "$bumped" | sort -V | tail -n 1)
else
    range="HEAD"
    version_name="$pubspec_version"
fi

commits=$(git log "$range" --pretty=format:'%s' || true)

track=""
while IFS= read -r line; do
    case "$line" in
        "[INTERNAL]"*) track="internal" ;;
        "[ALPHA]"*) track="alpha" ;;
        "[BETA]"*) track="beta" ;;
        *) continue ;;
    esac
    break
done <<< "$commits"

version_code=$(git rev-list --count HEAD)
tag="v${version_name}"

should_upload="true"
[[ -z "$track" ]] && should_upload="false"

notes_file="${RELEASE_NOTES_PATH:-release-notes.md}"
if [[ -n "$commits" ]]; then
    echo "$commits" | sed 's/^/- /' > "$notes_file"
else
    echo "Maintenance release." > "$notes_file"
fi

out="${GITHUB_OUTPUT:-/dev/stdout}"
{
    echo "version_name=${version_name}"
    echo "version_code=${version_code}"
    echo "tag=${tag}"
    echo "track=${track}"
    echo "should_upload=${should_upload}"
} >> "$out"

if [[ "$out" == "/dev/stdout" ]]; then
    echo "---"
    echo "Last release:   ${last_tag:-none (first release uses pubspec.yaml)}"
    echo "Next tag:       ${tag}"
    echo "versionName:    ${version_name}"
    echo "versionCode:    ${version_code}"
    echo "Upload to Play: ${should_upload}${track:+ (track: ${track})}"
fi
