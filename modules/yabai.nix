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
      window_border_width = "2";
      window_placement = "second_child";
      window_shadow = "float";
      active_window_border_color = "0xfff4b188";
      normal_window_border_color = "0xff000000";
      active_window_opacity = "1.0";
      normal_window_opacity = "1.0";
      focus_follows_mouse = "autoraise";
      mouse_follows_focus = "off";
      top_padding = "10";
      bottom_padding = "10";
      left_padding = "10";
      right_padding = "10";
      window_gap = "10";
    };

    extraConfig = ''
      yabai -m rule --add app='System Preferences' manage=off border=off layer=above
      yabai -m rule --add app='Activity Monitor' manage=off border=off layer=above
      yabai -m rule --add app='Finder' manage=off border=off layer=above
    '';
  };
}
