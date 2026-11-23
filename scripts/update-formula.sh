#!/usr/bin/env bash
set -euo pipefail

version="${1:?Usage: scripts/update-formula.sh <version>}"
formula="Formula/aislop.rb"
url="https://registry.npmjs.org/aislop/-/aislop-${version}.tgz"
archive="$(mktemp)"
trap 'rm -f "$archive" "$archive.files"' EXIT
curl -fsSL "$url" > "$archive"
sha256="$(shasum -a 256 "$archive" | awk '{print $1}')"
tar -tzf "$archive" > "$archive.files"
for platform in darwin-arm64 darwin-x64 linux-arm64 linux-x64; do
  grep -Fxq "package/tools/python/$platform/aislop-python" "$archive.files" || {
    echo "Missing Python engine for $platform in $url" >&2
    exit 1
  }
done
perl -0pi -e 's/^  depends_on "ruff"\n//m' "$formula"

perl -0pi -e "s#url \"https://registry\\.npmjs\\.org/aislop/-/aislop-[^\"]+\\.tgz\"#url \"$url\"#" "$formula"
perl -0pi -e "s#sha256 \"[a-f0-9]+\"#sha256 \"$sha256\"#" "$formula"
perl -0pi -e 's/^\s*revision\s+\d+\n//m' "$formula"

echo "Updated $formula to aislop $version ($sha256)"
