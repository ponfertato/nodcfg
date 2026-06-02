{
  description = "Ponfertato Nix-on-Droid configuration with modular structure";

  inputs = {
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      nix-on-droid,
      nixpkgs,
      nixpkgs-unstable,
      self,
      ...
    }@inputs:
    let
      mobileSystem = "aarch64-linux";

      unstableOverlay = final: prev: {
        unstable = import nixpkgs-unstable {
          system = mobileSystem;
          config.allowUnfree = true;
        };
      };

      mkNixOnDroidConfig =
        hostname:
        nix-on-droid.lib.nixOnDroidConfiguration {
          pkgs = import nixpkgs {
            system = mobileSystem;
            config.allowUnfree = true;
          };
          modules = [
            {
              nixpkgs.overlays = [ unstableOverlay ];
            }
            ./profiles/core
            ./profiles/user/ponfertato
            (./hosts + "/${hostname}/default.nix")
          ];
        };
    in
    {
      nixOnDroidConfigurations = {
        potatoPhone = mkNixOnDroidConfig "potatoPhone";
        potatoTablet = mkNixOnDroidConfig "potatoTablet";
      };
    };
}
