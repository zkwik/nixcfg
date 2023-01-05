{ pkgs, ... }:

{
  imports = [
    ./modules/emacs.nix
  ];

  home.packages = with pkgs; [
    jq
    slack
    spotify-tui
  ];

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

    shellAliases = {
      ls = "ls -G";
      sptr = "launchctl kickstart -k gui/502/org.nixos.spotifyd";
    };
  };

  programs.go = {
    enable = true;
  };

  programs.java = {
    enable = true;
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "Cascadia Code";
      size = 13;
    };
    theme = "Doom One";
    settings = {
      hide_window_decorations = "titlebar-only";
      window_padding_width = 20;
      tab_bar_margin_width = 20;
      background_opacity = "0.95";
      macos_thicken_font = "0.50";
    };
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        extraOptions = {
          IdentityAgent = "~/.1password/agent.sock";
        };
      };
    };
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
