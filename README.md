# aislop Homebrew tap

Homebrew tap for installing the `aislop` CLI.

This tap installs the published release for the matching version. It exposes:

- `aislop`
- `aislop-mcp`

## Install

Private install while this repo is private:

```sh
brew tap scanaislop/tap git@github.com:scanaislop/homebrew-tap.git
brew install scanaislop/tap/aislop
```

Local checkout install for testing formula changes:

```sh
brew tap scanaislop/tap "$(pwd)"
brew install scanaislop/tap/aislop
```

Public install after the repo is made public:

```sh
brew tap scanaislop/tap
brew install aislop
```

## Use

```sh
aislop scan
aislop fix
aislop ci
aislop-mcp
```

Homebrew installs Node.js as a dependency if needed.

## Versioning Model

Homebrew formulae should not install `latest`. A formula pins:

- the exact source tarball URL
- the SHA-256 checksum for that tarball
- the dependency list needed to run it

That is why `Formula/aislop.rb` points at a specific release tarball such as `aislop-0.10.2.tgz`.

Users still get newer versions through the normal Homebrew flow after this tap is updated:

```sh
brew update
brew upgrade aislop
```

They can also run `aislop upgrade` to check whether a newer release is available.

## Upgrade Users

After the formula is updated and pushed:

```sh
brew update
brew upgrade aislop
```

For private installs, users may need:

```sh
brew update-reset scanaislop/tap
brew upgrade scanaislop/tap/aislop
```

Users can run `aislop upgrade` at any time to check whether a newer release is available.

## Update The Formula

Run this after a new `aislop` version is published:

```sh
scripts/update-formula.sh 0.10.3
```

Then validate:

```sh
brew style ./Formula/aislop.rb
brew untap scanaislop/tap
brew tap scanaislop/tap "$(pwd)"
brew reinstall scanaislop/tap/aislop
brew test scanaislop/tap/aislop
```

Commit and push:

```sh
git add Formula/aislop.rb
git commit -m "Update aislop to 0.10.3"
git push
```

## Public Launch

When ready:

1. Change `scanaislop/homebrew-tap` visibility from private to public.
2. Keep the repo name as `homebrew-tap`; that maps to `brew tap scanaislop/tap`.
3. Verify from a clean machine:

```sh
brew tap scanaislop/tap
brew install aislop
aislop --version
```

## Troubleshooting

If `brew install` succeeds but linking fails because `/opt/homebrew/bin/aislop` already exists, the user already has another `aislop` install. They should remove the older install or choose one install source.

Or overwrite the existing symlinks intentionally:

```sh
brew link --overwrite aislop
```

Check what Homebrew installed:

```sh
brew info scanaislop/tap/aislop
brew list scanaislop/tap/aislop
```
