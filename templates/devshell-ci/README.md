# devshell-ci template

Creates a flake with a formatter-enabled dev shell and CI that uses:

- `rummik/nix-actions/actions/setup-nix@v0`
- `rummik/nix-actions/actions/nix-develop-run@v0`
- `rummik/nix-actions/actions/nix-flake-check@v0`

The generated workflow checks out `rummik/nix-actions` and runs local action paths from that checkout.

Use it with:

```bash
nix flake init -t github:rummik/nix-actions#devshell-ci
```
