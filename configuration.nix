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

  # TODO: Migrate remaining casks to nixpkgs when available/possible.
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
      "slack"
    ];

    masApps = {
      "Vimari" = 1480933944;
      "Noir – Dark Mode for Safari" = 1592917505;
      "Vinegar - Tube Cleaner" = 1591303229;
      "Baking Soda - Tube Cleaner" = 1591303229;
      "Wipr" = 1320666476;
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
    dock = {
      autohide = true;
      mru-spaces = false;
    };
  };

  nix.settings.trusted-users = [ "root" "${user}" ];
  
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
