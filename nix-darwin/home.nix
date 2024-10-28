{ config, pkgs, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  programs.home-manager.enable = true;
  manual.html.enable = true;
  home.username = "timotheos";
  home.homeDirectory = "/Users/timotheos";

  home.stateVersion = "23.11";

  ######## INSTALL PACKAGES #########

  # home.packages = with pkgs; [ ];

  # services = {
  #   gpg-agent = {
  #     enable = true;
  #     extraConfig = ''
  #       pinentry-program /usr/local/bin/pinentry-touchid
  #     '';
  #   };
  # };

  ######## CONFIGURE (AND INSTALL) PACKAGES USING NATIVE NIX OPTIONS ########

  programs = {
    # aria2.enable = true;
    # atuin.enable = true;
    # bat.enable = true;
    # eza.enable = true;
    # fd.enable = true;
    # fzf.enable = true;
    # git = {
    #   enable = true;
    #   delta.enable = true;
    # };
    # java = {
    #   enable = true;
    #   package = pkgs.zulu; # Certified builds of OpenJDK
    # };
    # jq.enable = true;
    # keychain.enable = true;
    # lazygit.enable = true;
    # neovim.enable = true;
    # pyenv.enable = true;
    # qt.enable = true;
    # rbenv.enable = true;
    # ripgrep = enable;
    # thefuck.enable = true;
    # tmux = {
    #   enable = true;
    #   tmuxp.enable = true;
    # };
    # vscode = {
    #   enable = true;
    #   # disallow extensions being installed or updated manually by vscode
    #   mutableExtensionsDir = false;
    #   enableUpdateCheck = false;
    #   enableExtensionUpdateCheck = false;
    #   extensions = with pkgs.vscode-marketplace; [
    #     # https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/vscode-marketplace-latest.json
    #     dbaeumer.vscode-eslint
    #     formulahendry.code-runner
    #     ms-vscode-remote.remote-containers
    #     ritwickdey.liveserver
    #   ];
    #     # ++ (with pkgs.open-vsx; [
    #     # https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/open-vsx-latest.json
    #     # ]);
    # };
    # yt-dlp.enable = true;
    # zoxide.enable = true;
    zsh = {
      enable = true;
      antidote.enable = true;
      # zsh-abbr.enable = true;
      # zsh-syntax-highlighting.enable = true;
    };
    # tmux = import ../home/tmux.nix { inherit pkgs; };
    # zsh = import ../home/zsh.nix { inherit config pkgs; };
    # #zoxide = (import ../home/zoxide.nix { inherit config pkgs; });
    # fzf = import ../home/fzf.nix { inherit pkgs; };
  };

  ####### CONFIGURE PACKAGES USING DOTFILES ########

  # link config file or whole directory to ~
  # home.file."foo".source = ./bar;

  # link the contents of a directory to ~
  # home.file."bin" = {
  #   source = ./bin;
  #   recursive = true;
  #   executable = true;
  # };

  # link config file/directory to ~/.config
  # xdg = {
  #   enable = true;
  #   configFile."foo" = {
  #     source = ./bar;
  #   };
  # };

  # link without copying to nix store (manage externally) - must use absolute paths
  # xdg.configFile.nvim.source = mkOutOfStoreSymlink "/Users/timotheos/.dotfiles/.config/nvim";

}
