# nix-actions

A collection of GitHub Actions for Nix dev/build environements.

## Included actions

| Action                      | Description                                                                   |
| --------------------------- | ----------------------------------------------------------------------------- |
| [actions/setup-nix][]       | Installs Nix using DeterminateSystems and optionally enables Magic Nix Cache. |
| [actions/nix-flake-check][] | Runs `nix flake check`.                                                       |
| [actions/nix-build][]       | Runs `nix build` for a chosen attribute.                                      |
| [actions/nix-develop-run][] | Enters `nix develop` and runs an arbitrary command.                           |
| [actions/direnv-export][]   | Exports `direnv` environment variables for use in subsequent steps.           |

[actions/setup-nix]: ./actions/setup-nix
[actions/nix-flake-check]: ./actions/nix-flake-check
[actions/nix-build]: ./actions/nix-build
[actions/nix-develop-run]: ./actions/nix-develop-run
[actions/direnv-export]: ./actions/direnv-export

Inputs and usage for each action are described in their respective `action.yml` files.

## Flake templates

This repo exposes `nix flake init` templates that include workflows using these actions.

| Template        | Description                                                           |
| --------------- | --------------------------------------------------------------------- |
| [basic-ci][]    | Minimal flake + CI for `nix flake check` and `nix build .#default`.   |
| [devshell-ci][] | Flake with `alejandra` in dev shell + CI formatting and flake checks. |
| [release-ci][]  | Flake with CI plus tag-triggered GitHub release workflow.             |

[basic-ci]: ./templates/basic-ci
[devshell-ci]: ./templates/devshell-ci
[release-ci]: ./templates/release-ci

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
      - uses: rummik/nix-actions/actions/nix-flake-check@v0

  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v6.0.2
      - uses: rummik/nix-actions/actions/setup-nix@v0
      - uses: rummik/nix-actions/actions/nix-build@v0
        with:
          package: .#my-package
```
