{ config, lib, pkgs, ... }:

{
  services.yabai = {
    enable = true;
    package = pkgs.yabai-5_0_2;
    enableScriptingAddition = true;

    config = {
      layout = "bsp";
      auto_balance = "off";
      split_ratio = "0.50";
      window_border = "on";
      window_border_width = "3";
      window_placement = "second_child";
      active_window_border_color = "0xff81a1c1";
      normal_window_border_color = "0xff3b4252";
      focus_follows_mouse = "autoraise";
      mouse_follows_focus = "off";
      top_padding = "10";
      bottom_padding = "10";
      left_padding = "10";
      right_padding = "10";
      window_gap = "10";
    };

    extraConfig = ''
      yabai -m rule --add app='System Preferences' manage=off layer=above
      yabai -m rule --add app='Activity Monitor' manage=off layer=above
      yabai -m rule --add app='Finder' manage=off layer=above
      yabai -m rule --add app='^Emacs$' manage=on
    '';
  };
}
