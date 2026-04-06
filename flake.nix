{
  description = "Description for the project";

  nixConfig = {
    extra-experimental-features = [ "nix-command" "flakes" ];
    extra-substituters = [
      "https://cache.nixos.org"
      "https://cache.flakehub.com"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbM4Nf4Q2wLk6LQj92t+6f6f7I="
      "cache.flakehub.com-3:hjuvDMLB9sMIf0ABFBb6/GfN5fNQnVg4M2DXrQ4hY8A="
    ];
  };

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.11";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        # To import an internal flake module: ./other.nix
        # To import an external flake module:
        #   1. Add foo to inputs
        #   2. Add foo as a parameter to the outputs function
        #   3. Add here: foo.flakeModule

      ];
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.

        # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
        packages.default = pkgs.hello;
      };
      flake = {
        templates = {
          basic-ci = {
            path = ./templates/basic-ci;
            description = "Minimal flake with CI that runs flake check and default build via nix-actions";
          };
          devshell-ci = {
            path = ./templates/devshell-ci;
            description = "Flake with devshell formatting check and flake check via nix-actions";
          };
          release-ci = {
            path = ./templates/release-ci;
            description = "Flake with CI plus tag-triggered GitHub release workflow";
          };
          default = {
            path = ./templates/basic-ci;
            description = "Alias for basic-ci";
          };
        };
      };
    };
}
