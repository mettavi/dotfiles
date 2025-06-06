{ pkgs, ... }:
{
  imports = [ ./mac ];

  system.defaults = {
    dock.autohide = true;
    # check current setting with "defaults read NSGlobalDomain '<insert setting here>'"
    NSGlobalDomain = {
      AppleKeyboardUIMode = 2;
      ApplePressAndHoldEnabled = false;
      # GUI steps (L to R): InitialKeyRepeat: 120, 94, 68, 35, 25, 15 / KeyRepeat: 120, 90, 60, 30, 12, 6, 2
      # (See https://apple.stackexchange.com/questions/261163/default-value-for-nsglobaldomain-initialkeyrepeat)
      InitialKeyRepeat = 35; # default 25
      KeyRepeat = 6; # default 6
    };
    trackpad = {
      TrackpadThreeFingerDrag = true;
    };
  };

  # pam_reattach.so re-enables pam_tid.so in tmux
  environment.etc."pam.d/sudo_local".text = /* bash */ ''
    # Managed by Nix Darwin
    auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
    auth       sufficient     pam_tid.so
  '';
}
