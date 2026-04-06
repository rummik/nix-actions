# release-ci template

Creates a flake with CI and a tag-based GitHub release workflow.

The CI workflow checks out `rummik/nix-actions` and runs local action paths from that checkout.

Included workflows:

- `ci.yml`: flake check + default build
- `release.yml`: publishes GitHub releases for tags matching `v*`

Use it with:

```bash
nix flake init -t github:rummik/nix-actions#release-ci
```
