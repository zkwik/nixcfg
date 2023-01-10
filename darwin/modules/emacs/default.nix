{ config, lib, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsUnstable.overrideAttrs (o: {
      patches = (o.patches or [ ]) ++ [
        ./patches/no-titlebar-and-round-corners.patch
        ./patches/no-frame-refocus-cocoa.patch
        ./patches/fix-window-role.patch
        ./patches/system-appearance.patch
      ];
    });
  };
}
