{
  environment.variables.HOMEBREW_NO_ANALYTICS = "1";

  system.defaults = {
    CustomUserPreferences = {
      # set iterm2 to write user prefs to custom file
      "com.googlecode.iterm2" = {
        "com.googlecode.iterm2.PrefsCustomFolder" = "$DOTFILES/modules/iterm2";
        "com.googlecode.iterm2.LoadPrefsFromCustomFolder" = true;
      };
    };
  };

  homebrew = {
    enable = true;

    # set to false as the brew version is pinned by the nix-homebrew package
    onActivation.autoUpdate = false;

    # allow upgrading outdated formulae during system activation
    # (after updating taps with "flake update")
    onActivation.upgrade = true;

    # don't attempt to autoUpdate when running brew commands manually
    global.autoUpdate = false;

    # uninstall removes formulae, zap removes formulae and casks
    onActivation.cleanup = "zap";
    # explicitly list taps to prevent "zap" option from attempting to untap them
    # NB: this is not necessary for homebrew-core
    # taps cannot be uninstalled here, they are managed by nix-homebrew.nix
    taps = [
      "homebrew/cask"
      "Kegworks-App/Kegworks"
      "jorgelbg/tap"
    ];
    brews = [
      # "m4b-tool"
      "pinentry-touchid"
    ];
    # use the "greedy" option to always upgrade auto-updated or unversioned cask to latest version
    casks = [
      # "abbyy-finereader-pdf"
      # "adobe-digital-editions"
      "anki"
      "calibre" # Comprehensive e-book software
      # "carbon-copy-cloner"
      # "cheatsheet"
      "cirrus" # Inspector for iCloud Drive folders
      # "coteditor"
      "customshortcuts" # Customise menu item keyboard shortcuts, integrates with keyclu
      "daisydisk" # Disk space visualiser

      # "discord"
      # "google-drive"
      # "isyncr"
      # iterm2 brew updates are more recent compared to the nix package
      {
        name = "iTerm2";
        greedy = true;
      }
      {
        name = "kegworks";
        args = {
          no_quarantine = true;
        };
      }
      "keyclu" # popup window showing application's shortcuts
      # key-codes
      "kid3"
      {
        name = "lingon-x";
        greedy = true;
      }
      # "mamp"
      # "masscode"
      # "mounty"
      # "microsoft-excel"
      # "microsoft-onenote"
      # "microsoft-powerpoint"
      # "microsoft-word"
      "musicbrainz-picard"
      # PDF reader, editor and annotator
      {
        name = "pdf-expert";
        greedy = true;
      }
      # "plex-media-server"
      "private-internet-access"
      # "qlmarkdown"
      # Mux and tag mp4 files
      {
        name = "subler";
        greedy = true;
      }
      # "syncmate"
      # "tor-browser"
      # "typora"
      "vmware-fusion" # Create, manage, and run virtual machines
      "xcodes"
      # "zotero"
    ];
    # BUG: Don't use until mas version 2.0 is released with a bug fix (see https://github.com/mas-cli/mas/issues/724)
    # WhatsApp is currently installed via mas, manage it via AppStore GUI for now
    masApps = {
      # "Contacts Sync for Google Gmail" = 451691288;
      # "Foldor" = 1559426624;
      # "GarageBand" = 682658836;
      # "iMovie" = 408981434;
      # "Keynote" = 409183694;
      # "Numbers" = 409203825;
      # "Pages" = 409201541;
      # "PastePal" = 1503446680;
      # "Patterns" = 429449079;
      # "PDF Squeezer" = 1502111349;
      # "PDFgear" = 6469021132;
      # "Snip" = 1527428847;
      # "Sync Folders Pro" = 522706442;
      # "tipitaka_pali_reader" = 1541426949;
      # "WhatsApp Messenger" = 310633997;
    };
  };
}
