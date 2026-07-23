#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
test_dir="$(mktemp -d)"
formula="$test_dir/Formula/aislop.rb"
fixture_payload="deterministic aislop formula updater fixture"
target_version="9.9.9"

mkdir -p "$test_dir/Formula" "$test_dir/scripts" "$test_dir/bin"
cp "$repo_root/Formula/aislop.rb" "$formula"
cp "$repo_root/scripts/update-formula.sh" "$test_dir/scripts/update-formula.sh"

perl -0pi -e 's/^\s*revision\s+\d+\n//m' "$formula"
perl -0pi -e 's/(^\s*license "[^"]+"\n)/$1  revision 7\n/m' "$formula"

printf '%s\n' '#!/usr/bin/env bash' \
	'printf "%s" "deterministic aislop formula updater fixture"' >"$test_dir/bin/curl"
chmod +x "$test_dir/bin/curl"

expected_sha="$(printf "%s" "$fixture_payload" | shasum -a 256 | awk '{print $1}')"

(
	cd "$test_dir"
	PATH="$test_dir/bin:$PATH" scripts/update-formula.sh "$target_version"

	! grep -Eq '^[[:space:]]*revision[[:space:]]+[0-9]+' "$formula"
	grep -Fq "url \"https://registry.npmjs.org/aislop/-/aislop-${target_version}.tgz\"" "$formula"
	grep -Fq "sha256 \"${expected_sha}\"" "$formula"
	grep -Fq 'class Aislop < Formula' "$formula"
	grep -Fq 'depends_on "golangci-lint"' "$formula"
	grep -Fq 'depends_on "ruff"' "$formula"
	ruby -c "$formula"
	brew style "$formula"
)
