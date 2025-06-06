{
  user1,
  config,
  ...
}:
{
  sops = {
    defaultSopsFile = ../../modules/secrets/secrets.yaml;
    # If you use something differentfrom YAML, you can also specify it here:
    #sops.defaultSopsFormat = "yaml";
    age = {
      # automatically import host SSH keys as age keys
      # NB: ssh host keys can be generated with the "ssh-keygen -A" command
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      # This will generate an age format key from the host ssh key if one does not exist
      generateKey = true;
    };
    gnupg.sshKeyPaths = [ ];
    # secrets will be output to /run/secrets
    # e.g. /run/secrets/msmtp-password
    # secrets required for user creation are handled in respective ./users/<username>.nix files
    # because they will be output to /run/secrets-for-users and only when the user is assigned to a host.
    secrets = {
      # For home-manager a separate age key is used to decrypt secrets and must be placed onto the host. This is because
      # the user doesn't have read permission for the ssh service private key. However, we can bootstrap the age key from
      # the secrets decrypted by the host key, which allows home-manager secrets to work without manually copying over
      # the age key. These age keys are unique for the user on each host and are generated on their own (i.e. they are not derived
      # from an ssh key).
      "users/${user1}/encryption_key" = {
        owner = "${config.users.users.${user1}.name}";
        # We need to ensure the entire directory structure is that of the user...
        path = "${config.users.users.${user1}.home}/.config/sops/age/keys.txt";
      };
      "users/${user1}/google_timotheos_app_pw" = {
      };
    };
    templates = {
      "sasl_passwd" = {
        content = # bash
          ''
            [smtp.gmail.com]:587 timotheos.allen@gmail.com:${config.sops.placeholder."users/${user1}/google_timotheos_app_pw"}
          '';
        path = "/etc/postfix/sasl_passwd";
      };
    };
  };
  # The containing folders are created as root and if this is the first ~/.config/ entry,
  # the ownership is busted and home-manager can't target because it can't write into .config...
  # FIXME:(sops) We might not need this depending on how https://github.com/Mic92/sops-nix/issues/381 is fixed
  # system.activationScripts.sopsSetAgeKeyOwnership =
  #   let
  #     ageFolder = "${config.users.users.ta.home}/.config/sops/age";
  #     user = config.users.users.ta.name;
  #     group = "staff";
  #   in
  #   ''
  #     mkdir -p ${ageFolder} || true
  #     chown -R ${config.users.users.ta.name}:${group} "${config.users.users.ta.home}/.config";
  #   '';
}
