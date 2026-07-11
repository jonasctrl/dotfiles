{
  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      "com.apple.swipescrolldirection" = false;
    };
    dock = {
      autohide = true;
      tilesize = 46;
      show-recents = false;

      # Group windows by application in Mission Control; otherwise aerospace's
      # corner-stashed windows make all thumbnails unreadably small.
      expose-group-apps = true;
    };
    finder.FXPreferredViewStyle = "Nlsv";

    controlcenter.BatteryShowPercentage = true;

    WindowManager = {
      EnableTiledWindowMargins = false;
      EnableTopTilingByEdgeDrag = false;
    };

    CustomUserPreferences = {
      "com.apple.symbolichotkeys".AppleSymbolicHotKeys = {
        # Disable built-in Spotlight.
        "64".enabled = false;
      };
      "com.raycast.macos" = {
        # Enable Raycast cmd+space shortcut.
        raycastGlobalHotkey = "Command-49";
      };
      "com.knollsoft.Rectangle" = {
        launchOnLogin = true;
        hideMenubarIcon = true;
        allowAnyShortcut = true;
        gapSize = 26;
        # Shortcut for max window: cmd+opt+return
        maximize = { keyCode = 36; modifierFlags = 1572864; };
      };
    };
  };
}
