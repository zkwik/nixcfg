{ pkgs, ... }:

{
  imports = [
    ./modules/emacs.nix
  ];

  home.packages = with pkgs; [];

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
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";
}
