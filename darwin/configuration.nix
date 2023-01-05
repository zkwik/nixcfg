{ config, pkgs, user, ... }:

{
  imports = [
    ./modules/yabai.nix
    ./modules/skhd.nix
  ];

  users.users."${user}" = {
    home = "/Users/${user}";
    shell = pkgs.zsh;
  };

  networking.hostName = "SE-FK4L0DX7HC";

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      cascadia-code
      iosevka
    ];
  };

  environment = {
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [ ];
  };

  services.nix-daemon.enable = true;

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.cleanup = "zap";
    global.brewfile = true;

    taps = [
      "homebrew/core"
      "homebrew/cask"
    ];

    casks = [
      "1password"
      "1password/tap/1password-cli"
      "alfred"
      "docker"
    ];

    masApps = {
      "Vimari" = 1480933944;
      "Noir – Dark Mode for Safari" = 1592917505;
      "Vinegar - Tube Cleaner" = 1591303229;
      "Baking Soda - Tube Cleaner" = 1591303229;
      "Wipr" = 1320666476;
    };
  };

  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      interval.Day = 7;
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
    '';
    settings = {
      trusted-users = [ "root" "${user}" ];
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  programs.zsh.enable = true;

  services.spotifyd = {
    enable = true;
    settings = {
      username = "ericottosson";
      password_cmd = "op item get Spotify --fields label=password";
      bitrate = 320;
      volume_normalisation = true;
      device_name = "${config.networking.hostName}";
      device_type = "computer";
    };
  };

  system.defaults = {
    NSGlobalDomain = {
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
      AppleShowScrollBars = "WhenScrolling";
      AppleInterfaceStyle = "Dark";
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
    dock = {
      autohide = true;
      mru-spaces = false;
    };
    finder = {
      FXPreferredViewStyle = "Nlsv";
      _FXShowPosixPathInTitle = true;
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
