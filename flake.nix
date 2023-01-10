{
  description = "My personal Darwin configuration";

  nixConfig = {
    extra-substituters = "https://nix-community.cachix.org";
    extra-trusted-public-keys = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO: Move back to official pkg once this is merged
    #       https://nixpk.gs/pr-tracker.html?pr=203504
    nixpkgs-yabai-5_0_2.url = "github:IvarWithoutBones/nixpkgs?rev=27d6a8b410d9e5280d6e76692156dce5d9d6ef86";
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }@inputs: let
    user = "eric.ottosson";
  in {
    darwinConfigurations.SE-FK4L0DX7HC = darwin.lib.darwinSystem rec {
      system = "aarch64-darwin";
      specialArgs = { inherit user; };
      modules = [
        ({ pkgs, ... }: {
          # Apply our overlays. We do this first so the overlays are available globally.
          nixpkgs.overlays = with inputs; [
            emacs-overlay.overlays.emacs

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
  };
}
