{ inputs, user1, system, ... }:
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user1} = import ../../common/users/${user1};
    # Optionally, use home-manager.extraSpecialArgs to pass
    # arguments to home-manager modules
    extraSpecialArgs = {
      inherit inputs system user1;
    };
    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
    ];
  };
}
