{
  description = "My personal NixOS and Darwin configuration";

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

  outputs = inputs@{ self, nixpkgs, home-manager, darwin, ... }: {
    darwinConfigurations = (
      import ./darwin {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager darwin;
      }
    );
  };
}
