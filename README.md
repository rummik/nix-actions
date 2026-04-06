# nix-actions

Reusable GitHub Actions for Nix-flake based repositories.

This repo starts with a practical baseline:

- Local composite actions for common Nix CI jobs
- Workflows to validate this repo itself
- A simple release workflow for tagging versions

## Included actions

### 1) actions/setup-nix

Installs Nix using DeterminateSystems and optionally enables Magic Nix Cache.

Inputs:

- `extra-nix-config` (default: empty)
- `use-magic-cache` (default: `false`)

### 2) actions/nix-flake-check

Runs `nix flake check`.

Inputs:

- `working-directory` (default: `.`)
- `extra-args` (default: empty)

### 3) actions/nix-build

Runs `nix build` for a chosen attribute.

Inputs:

- `working-directory` (default: `.`)
- `attribute` (default: `.#default`)
- `extra-args` (default: empty)
- `link-out-path` (default: `false`)

### 4) actions/nix-develop-run

Enters `nix develop` and runs an arbitrary command.

Inputs:

- `command` (required)
- `working-directory` (default: `.`)
- `devshell` (default: empty, meaning default shell)

## Included workflows

### CI

File: `.github/workflows/ci.yml`

- Runs `nix flake check` on Ubuntu and macOS
- Builds `.#default` on Ubuntu

### actionlint

File: `.github/workflows/actionlint.yml`

- Lints workflow syntax and structure

### release

File: `.github/workflows/release.yml`

- On tags matching `v*`, creates a GitHub release with generated notes

## Flake templates

This repo exposes `nix flake init` templates that include workflows using these actions.

- `basic-ci`: minimal flake + CI for `nix flake check` and `nix build .#default`
- `devshell-ci`: flake with `alejandra` in dev shell + CI formatting and flake checks
- `release-ci`: flake with CI plus tag-triggered GitHub release workflow

Use a template:

```bash
nix flake init -t github:rummik/nix-actions#basic-ci
# or
nix flake init -t github:rummik/nix-actions#devshell-ci
# or
nix flake init -t github:rummik/nix-actions#release-ci
```

## Example usage from another repo

```yaml
name: CI
on:
  pull_request:

jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v6.0.2
      - uses: rummik/nix-actions/actions/setup-nix@v0
        with:
          use-magic-cache: true
      - uses: rummik/nix-actions/actions/nix-flake-check@v0

  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v6.0.2
      - uses: rummik/nix-actions/actions/setup-nix@v0
        with:
          use-magic-cache: true
      - uses: rummik/nix-actions/actions/nix-build@v0
        with:
          attribute: .#my-package
```

## Next recommended tweaks

- Add `nix fmt` or `treefmt` checks once formatter settings are defined in the flake
- Add Cachix push support for trusted branches if you want faster downstream builds
- Add integration tests for each action in a dedicated fixture flake
