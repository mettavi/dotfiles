{
  user1,
  config,
  ...
}:
{
  sops = {
    defaultSopsFile = ../../../modules/secrets/secrets.yaml; # must have no password!
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    # It's also possible to use a ssh key, but only when it has no password:
    #age.sshKeyPaths = [ "/home/user/path-to-ssh-key" ];

    secrets = {
      "users/${user1}/ssh_keys/timotheos_ed25519" = {
        path = "${config.home.homeDirectory}/.ssh/timotheos_ed25519";
      };
      "users/${user1}/ssh_keys/timotheos_ed25519.pub" = {
        path = "${config.home.homeDirectory}/.ssh/timotheos_ed25519.pub";
      };
      "users/${user1}/ssh_keys/ssh-nixos-ocloud.key" = {
      };
      "users/${user1}/github_token" = {
      };
      "users/${user1}/cachix_auth_token" = {
      };
      # rclone auth token for onedrive service
      "users/${user1}/rclone_1d_token" = {
      };
      # rclone application key for backblaze b2 service
      "users/${user1}/rclone_b2_appkey" = {
      };
      # restic key for encryption of backblaze b2 repo (mbp_timotheos)
      "users/${user1}/restic_b2_mack-timotheos" = {
      };
    };
    templates = {
      # rclone config file with secret
      "rclone.conf" = {
        content = ''
          [onedrive]
          type = onedrive
          token = ${config.sops.placeholder."users/${user1}/rclone_1d_token"}
          drive_id = 0F811515C935D85C
          drive_type = personal
          hard_delete = true
          
          [b2]
          type = b2
          account = 004471da6ad00020000000001
          key = ${config.sops.placeholder."users/${user1}/rclone_b2_appkey"}
        '';
        path = "${config.xdg.configHome}/rclone/rclone.conf";
      };
    };
    # secrets.test = {
    #   # sopsFile = ./secrets.yml.enc; # optionally define per-secret files
    #
    #   # %r gets replaced with a runtime directory, use %% to specify a '%'
    #   # sign. Runtime dir is $XDG_RUNTIME_DIR on linux and $(getconf
    #   # DARWIN_USER_TEMP_DIR) on darwin.
    #   path = "%r/test.txt";
    # };
  };
}
