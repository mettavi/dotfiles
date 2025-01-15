{
  pkgs,
  inputs,
  ...
}:
{
  nix = {
    # auto upgrade nix package
    package = pkgs.nix;
    gc.automatic = true;
    # this ensures $NIX_PATH is set to an immutable location in the nix-store
    nixPath = [
      "nixpkgs=${inputs.nixpkgs}"
      "darwin=${inputs.nix-darwin}"
      "home-manager=${inputs.home-manager}"
    ];
    optimise.automatic = true;
    settings = {
      # this setting is deprected, see https://bit.ly/3Cp2vYB
      # auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
      # substituters are always enabled, trusted-substituters can be enabled on demand by untrusted users
      substituters = [
        "https://nixpkgs.cachix.org"
        "https://nix-community.cachix.org"
        "https://cachix.cachix.org"
        "https://yazi.cachix.org"
        "https://mettavi.cachix.org"
      ];
      trusted-public-keys = [
        "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
        "mettavi.cachix.org-1:rYvLGZOMT4z4hK7u5pzrbt8svJ/2JcUA/PTa1bQx4FU="
      ];
      trusted-users = [ "root" ];
    };
  };
  # Auto upgrade the nix daemon service.
  services.nix-daemon.enable = true;

  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowBroken = true;
}