#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
test_dir="$(mktemp -d)"
formula="$test_dir/Formula/aislop.rb"
trap 'rm -rf "$test_dir"' EXIT
target_version="9.9.9"

mkdir -p "$test_dir/Formula" "$test_dir/scripts" "$test_dir/bin"
cp "$repo_root/Formula/aislop.rb" "$formula"
cp "$repo_root/scripts/update-formula.sh" "$test_dir/scripts/update-formula.sh"

perl -0pi -e 's/^\s*revision\s+\d+\n//m' "$formula"
perl -0pi -e 's/(^\s*license "[^"]+"\n)/$1  revision 7\n/m' "$formula"

for platform in darwin-arm64 darwin-x64 linux-arm64 linux-x64; do
	mkdir -p "$test_dir/package/tools/python/$platform"
	touch "$test_dir/package/tools/python/$platform/aislop-python"
done
tar -czf "$test_dir/release.tgz" -C "$test_dir" package
printf '%s\n' '#!/usr/bin/env bash' 'cat release.tgz' >"$test_dir/bin/curl"
chmod +x "$test_dir/bin/curl"

expected_sha="$(shasum -a 256 "$test_dir/release.tgz" | awk '{print $1}')"

(
	cd "$test_dir"
	PATH="$test_dir/bin:$PATH" scripts/update-formula.sh "$target_version"

	! grep -Eq '^[[:space:]]*revision[[:space:]]+[0-9]+' "$formula"
	grep -Fq "url \"https://registry.npmjs.org/aislop/-/aislop-${target_version}.tgz\"" "$formula"
	grep -Fq "sha256 \"${expected_sha}\"" "$formula"
	grep -Fq 'class Aislop < Formula' "$formula"
	grep -Fq 'depends_on "golangci-lint"' "$formula"
	if grep -Fq 'depends_on "ruff"' "$formula"; then exit 1; fi
	ruby -c "$formula"
	brew style "$formula"
)
