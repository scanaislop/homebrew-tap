#!/usr/bin/env bash
set -euo pipefail

version="${1:?Usage: scripts/update-formula.sh <version>}"
formula="Formula/aislop.rb"
url="https://registry.npmjs.org/aislop/-/aislop-${version}.tgz"
sha256="$(curl -fsSL "$url" | shasum -a 256 | awk '{print $1}')"

perl -0pi -e "s#url \"https://registry\\.npmjs\\.org/aislop/-/aislop-[^\"]+\\.tgz\"#url \"$url\"#" "$formula"
perl -0pi -e "s#sha256 \"[a-f0-9]+\"#sha256 \"$sha256\"#" "$formula"

echo "Updated $formula to aislop $version ($sha256)"
