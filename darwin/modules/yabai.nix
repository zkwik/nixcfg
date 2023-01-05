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
      window_shadow = "float";
      active_window_border_color = "0xff9a84ba";
      normal_window_border_color = "0xff0e215c";
      active_window_opacity = "1.0";
      normal_window_opacity = "1.0";
      focus_follows_mouse = "autoraise";
      mouse_follows_focus = "off";
      top_padding = "20";
      bottom_padding = "20";
      left_padding = "20";
      right_padding = "20";
      window_gap = "20";
    };

    extraConfig = ''
      yabai -m rule --add app='System Preferences' manage=off border=off layer=above
      yabai -m rule --add app='Activity Monitor' manage=off border=off layer=above
      yabai -m rule --add app='Finder' manage=off border=off layer=above
      yabai -m rule --add app='^Emacs$' manage=on
    '';
  };
}
