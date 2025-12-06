{
  pkgs,
  self,
  lib,
  ...
}:

let
  user = "junha";
in
{
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user} = ./home.nix;
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  # List packages installed in system profile.
  environment.systemPackages = [
    (pkgs.stdenv.mkDerivation {
      pname = "Alacritty";
      version = "0.16.1";

      src = pkgs.fetchurl {
        url = "https://github.com/alacritty/alacritty/releases/download/v0.16.1/Alacritty-v0.16.1.dmg";
        sha256 = "sha256-KFUsk5i3MrI67kggaBXSnzcHAoxsqagv2LTA0FyqlAo=";
      };

      buildInputs = [ pkgs.undmg ];
      sourceRoot = ".";

      phases = [
        "unpackPhase"
        "installPhase"
      ];

      installPhase = ''
        mkdir -p "$out/Applications"
        cp -r *.app "$out/Applications/"
      '';
    })
  ];

  homebrew = {
    enable = true;
    masApps = {
      "Keynote" = 409183694;
      "Numbers" = 409203825;
      "Pages" = 409201541;
      "Xcode" = 497799835;
      "1Password for Safari" = 1569813296;
      "RunCat" = 1429033973;
    };
    casks = [
    ];
  };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  system = {
    primaryUser = "junha";
    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
      };
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
      controlcenter = {
        BatteryShowPercentage = true;
      };
      dock = {
        expose-group-apps = true;
      };
      menuExtraClock = {
        ShowSeconds = true;
      };
      screencapture = {
        location = "~/Screenshots/";
      };
      trackpad = {
        Clicking = true;
        TrackpadFourFingerHorizSwipeGesture = 2;
        TrackpadFourFingerPinchGesture = 2;
        TrackpadFourFingerVertSwipeGesture = 2;
        TrackpadPinch = true;
        TrackpadRightClick = true;
        TrackpadRotate = true;
        TrackpadThreeFingerDrag = true;
        TrackpadTwoFingerDoubleTapGesture = true;
        TrackpadTwoFingerFromRightEdgeSwipeGesture = 3;
      };

      CustomUserPreferences = {
        "com.apple.finder" = {
          NewWindowTarget = "Home";
        };
        "com.apple.screensaver" = {
          # Require password immediately after sleep or screen saver begins
          askForPassword = 1;
          askForPasswordDelay = 0;
        };
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };
        "com.apple.symbolichotkeys" = {
          AppleSymbolicHotKeys = {
            # Select the previous input source
            "60" = {
              enabled = true;
              value = {
                parameters = [
                  32
                  49 # space
                  1048576 # cmd
                ];
                type = "standard";
              };
            };
            # 61: Select next source in Input menu
            "61" = {
              enabled = false;
              value = {
                parameters = [
                  32
                  49 # space
                  1572864 # cmd + opt
                ];
                type = "standard";
              };
            };
            # 64: Show Spotlight search
            "64" = {
              enabled = true;
              value = {
                parameters = [
                  65535
                  49 # space
                  262144 # ctrl
                ];
                type = "standard";
              };
            };
            # 65: Show Finder search window
            "65" = {
              enabled = true;
              value = {
                parameters = [
                  65535
                  49 # space
                  786432 # ctrl + opt
                ];
                type = "standard";
              };
            };
          };
        };
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    # Set Git commit hash for darwin-version.
    configurationRevision = self.rev or self.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 6;
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  nixpkgs = {
    config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "vscode"
      ];
  };
}
