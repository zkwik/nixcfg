{ config, lib, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsUnstable.overrideAttrs (o: {
      patches = (o.patches or [ ]) ++ [
        ./emacs/no-titlebar-and-round-corners.patch
        ./emacs/no-frame-refocus-cocoa.patch
        ./emacs/fix-window-role.patch
        ./emacs/system-appearance.patch
      ];
    });
  };
}
