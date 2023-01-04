{ config, lib, pkgs, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  programs.emacs = {
    enable = true;
    package = (pkgs.emacsWithPackagesFromUsePackage {
      config = ../../apps/emacs/init.el;
      package = pkgs.emacsGit;
      alwaysEnsure = true;
    });
  };

  home.file.".emacs.d/init.el".source = mkOutOfStoreSymlink ../../apps/emacs/init.el;
  home.file.".emacs.d/early-init.el".source = mkOutOfStoreSymlink ../../apps/emacs/early-init.el;  
  home.file.".emacs.d/settings.el".source = mkOutOfStoreSymlink ../../apps/emacs/settings.el;
}
