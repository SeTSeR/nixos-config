{ config, pkgs, lib, ... }:
let readWithSubstitute = file:
      builtins.readFile (pkgs.substituteAll ((import ./subst.nix { inherit config pkgs lib; }) //
                                             { src = file; }));
      modulePaths = dir: map (fname: dir + "/${fname}") (builtins.attrNames (builtins.readDir dir));
in {
  home-manager.users.smakarov = {
    programs.emacs = {
      enable = true;
      package = config.emacsPackage;
    };

    xdg.configFile."emacs/early-init.el".source = ./early-init.el;
    xdg.configFile."emacs/init.el".text =
      readWithSubstitute ./init.el
      + lib.concatStringsSep "\n" (map readWithSubstitute (modulePaths ./modules));
    xdg.configFile."emacs/yasnippet-snippets".source = ./yasnippet-snippets;
  };
}
