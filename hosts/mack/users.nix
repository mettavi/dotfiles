{ user1, ...}:
  { users.users.${user1} = {
    name = "${user1}";
    home = "/Users/${user1}";
    # authorize remote login to host using personal ssh key
    openssh.authorizedKeys.keys = [
      (builtins.readFile ../../common/users/${user1}/keys/timotheos_ed25519.pub)
    ];
  };

  imports = [ ../../common/users/${user1}/darwin.nix];

 }
