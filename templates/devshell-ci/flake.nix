{
  description = "Flake template with devshell checks using rummik/nix-actions";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.11";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { pkgs, ... }: {
        formatter = pkgs.alejandra;

        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.alejandra
            pkgs.nixd
          ];
        };
      };
    };
}
