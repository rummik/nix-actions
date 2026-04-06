{
  description = "Basic flake template with CI using rummik/nix-actions";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.11";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { pkgs, self', ... }: {
        packages.default = pkgs.hello;
        checks.default = self'.packages.default;
      };
    };
}
