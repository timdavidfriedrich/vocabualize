#!/usr/bin/env bash
set -euo pipefail

# Every push to main builds the app. An upload to Google Play only happens when
# a commit since the last release tag contains [RELEASE] (minor bump) or
# [PATCH] / [HOTFIX] (patch bump). The first release uses the version in
# pubspec.yaml as is. versionCode is the commit count on the branch, so every
# build gets a unique, increasing code.
#
# Writes version_name, version_code, tag, should_upload and bump to
# $GITHUB_OUTPUT (or stdout when run locally) and the release notes to
# release-notes.md.

pubspec_version=$(sed -n 's/^version:[[:space:]]*\([0-9][0-9.]*\).*/\1/p' pubspec.yaml)
last_tag=$(git describe --tags --abbrev=0 --match 'v[0-9]*' --exclude '*-*' 2>/dev/null || true)

if [[ -n "$last_tag" ]]; then
    range="${last_tag}..HEAD"
    current="${last_tag#v}"
else
    range="HEAD"
    current="$pubspec_version"
fi

commits=$(git log "$range" --pretty=format:'%s' || true)

bump="none"
while IFS= read -r line; do
    [[ -z "$line" ]] && continue
    if [[ "$line" == *"[RELEASE]"* ]]; then
        bump="minor"
        break
    elif [[ ("$line" == *"[PATCH]"* || "$line" == *"[HOTFIX]"*) && "$bump" == "none" ]]; then
        bump="patch"
    fi
done <<< "$commits"

IFS='.' read -r major minor patch <<< "$current"
major=${major:-0}; minor=${minor:-0}; patch=${patch:-0}

if [[ -n "$last_tag" ]]; then
    case "$bump" in
        minor) minor=$((minor + 1)); patch=0 ;;
        patch) patch=$((patch + 1)) ;;
        none)  : ;;
    esac
fi

version_name="${major}.${minor}.${patch}"
version_code=$(git rev-list --count HEAD)
tag="v${version_name}"

should_upload="true"
[[ "$bump" == "none" ]] && should_upload="false"

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
    echo "should_upload=${should_upload}"
    echo "bump=${bump}"
} >> "$out"

if [[ "$out" == "/dev/stdout" ]]; then
    echo "---"
    echo "Last release:   ${last_tag:-none (first release uses pubspec.yaml)}"
    echo "Bump:           ${bump}"
    echo "Next tag:       ${tag}"
    echo "versionName:    ${version_name}"
    echo "versionCode:    ${version_code}"
    echo "Upload to Play: ${should_upload}"
fi
