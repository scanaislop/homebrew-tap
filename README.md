# homebrew-tap

Private Homebrew tap for aislop while distribution is being prepared.

Private install:

```sh
brew tap scanaislop/tap git@github.com:scanaislop/homebrew-tap.git
brew install scanaislop/tap/aislop
```

Public install, once the repository is public:

```sh
brew tap scanaislop/tap
brew install aislop
```

Until the repository is public, install from the checked-out tap:

```sh
brew tap scanaislop/tap "$(pwd)"
brew install scanaislop/tap/aislop
```
