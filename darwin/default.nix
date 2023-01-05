{ lib, inputs, nixpkgs, home-manager, darwin, ... }:

let
  system = "aarch64-darwin";
  user = "eric.ottosson";
in {
  SE-FK4L0DX7HC = darwin.lib.darwinSystem {
    inherit system;
    specialArgs = { inherit user inputs; };
    modules = [
      ({ pkgs, ... }: {
        nixpkgs.config.allowUnfree = true;

        nixpkgs.overlays = with inputs; [
          emacs-overlay.overlays.emacs
          emacs-overlay.overlays.package

          # TODO: Move back to official pkg once this is merged
          #       https://nixpk.gs/pr-tracker.html?pr=203504
          (self: super: { yabai-5_0_2 = (import nixpkgs-yabai-5_0_2 { inherit system; }).yabai; })
        ];
      })

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
