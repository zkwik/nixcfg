{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "eric.ottosson";
  home.homeDirectory = "/Users/eric.ottosson";

  fonts.fontconfig.enable = true;

  # Packages that should be installed to the user profile.
  home.packages = pkgs.callPackage ./packages.nix {};

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;

    ignores = [
      "*~"
      "#*#"
      ".emacs.desktop"
      ".emacs.desktop.lock"
      "*.elc"
      "auto-save-list"
      "tramp"
      ".#*"
    ];

    userName = "Eric Ottosson";
  };

  programs.kitty = {
    enable = true;
    font.name = "Iosevka";
    font.size = 13;
    theme = "Doom One";
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    defaultKeymap = "emacs";

    initExtra = ''
      autoload -U promptinit; promptinit
      prompt pure
    '';

    shellAliases = {
      ls = "ls -G";
    };
  };
}
