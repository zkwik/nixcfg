{ config, lib, pkgs, ... }:

{
  services.skhd = {
    enable = true;
    package = pkgs.skhd;

    skhdConfig = ''
      # open terminal
      cmd - return : kitty --single-instance -d ~

      # open emacs
      ctrl + alt + cmd - e : emacs

      # reload yabai
      ctrl + alt + cmd - r : launchctl kickstart -k "gui/''${UID}/org.nixos.yabai"

      # toggle window fullscreen
      alt - f : yabai -m window --toggle zoom-fullscreen

      # float / unfloat window and center on screen
      alt - t : yabai -m window --toggle float; yabai -m window --grid 4:4:1:1:2:2

      # close focused window
      alt - q : yabai -m window --close

      # focus window
      alt - h : yabai -m window --focus west
      alt - j : yabai -m window --focus south
      alt - k : yabai -m window --focus north
      alt - l : yabai -m window --focus east

      # swap window
      shift + alt - h : yabai -m window --swap west
      shift + alt - j : yabai -m window --swap south
      shift + alt - k : yabai -m window --swap north
      shift + alt - l : yabai -m window --swap east

      # focus space
      ctrl - 1 : yabai -m space --focus 1
      ctrl - 2 : yabai -m space --focus 2
      ctrl - 3 : yabai -m space --focus 3
      ctrl - 4 : yabai -m space --focus 4
      ctrl - 5 : yabai -m space --focus 5

      # send window to space and follow focus
      shift + ctrl - 1 : yabai -m window --space 1; yabai -m space --focus 1
      shift + ctrl - 2 : yabai -m window --space 2; yabai -m space --focus 2
      shift + ctrl - 3 : yabai -m window --space 3; yabai -m space --focus 3
      shift + ctrl - 4 : yabai -m window --space 4; yabai -m space --focus 4
      shift + ctrl - 5 : yabai -m window --space 5; yabai -m space --focus 5

      # media keys
      play : spt playback --toggle
      previous : spt playback --previous
      next : spt playback --next
    '';
  };

  system.keyboard.enableKeyMapping = true;
}
