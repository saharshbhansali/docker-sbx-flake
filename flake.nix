{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
      };

    outputs = {self, nixpkgs, ...}@inputs: let
      forAllSys = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.all;
    in {
        packages = forAllSys (
          system: let
            pkgs = import nixpkgs {
              inherit system;
              config = {};
              overlays = [];
            };
            sbx = pkgs.callPackage ./pkgs/sbx.nix {
                inherit (inputs) nixpkgs;
              };
            in {
                default = sbx;
              }
        );
      };

  }
