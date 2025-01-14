{ pkgs, ... }:
let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "main";
    hash = "";
  };
  yazi-flavors = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "flavors";
    rev = "main";
    hash = "sha256-Zi+54ZwoXDKKeUHSTYkif8m0FKx6V8nA6mByaVyBrks=";
  };
in
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    flavors = {
      catppuccin-mocha = "${yazi-flavors}/catppuccin-mocha.yazi";
    };
    keymap = {
      manager.prepend_keymap = [
        {
          on = [ "<S-a>" ];
          run = "toggle_all --state=on";
          desc = "Select all files";
        }
      ];
    };
    settings = {
      manager = {
        show_hidden = true;
      };
    };
    theme = {
      flavor = {
        dark = "catppuccin-mocha";
        light = "catppuccin-mocha";
      };
    };
    shellWrapperName = "y";
  };
}
