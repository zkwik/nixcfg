{ lib, inputs, nixpkgs, home-manager, darwin, ... }:

let
  system = "aarch64-darwin";
  user = "eric.ottosson";
in {
  SE-FK4L0DX7HC = darwin.lib.darwinSystem {
    inherit system;
    specialArgs = { inherit user inputs; };
    modules = [
      ({ pkgs, ... }: { nixpkgs.overlays = [ inputs.emacs-overlay.overlays.emacs ]; })

      ./configuration.nix

      home-manager.darwinModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = import ./home.nix;
      }
    ];
  };
}
