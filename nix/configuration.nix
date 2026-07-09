{ user, ... }:

{
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = 6;

  system.primaryUser = user;
  users.users.${user}.home = "/Users/${user}";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # NOTE: defaults run Sun 03:15 (gc) and 04:15 (optimise); missed runs fire on wake.
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 14d";
  };
  nix.optimise.automatic = true;

  programs.zsh.enable = true;
  # NOTE: otherwise /etc/zshrc runs a compinit that prompts about insecure files.
  programs.zsh.enableGlobalCompInit = false;

  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      "com.apple.swipescrolldirection" = false;
    };
    dock = {
      autohide = true;
      tilesize = 46;
      show-recents = false;
    };
    finder.FXPreferredViewStyle = "Nlsv";
  };

  nix-homebrew = {
    enable = true;
    inherit user;
    enableRosetta = true;
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = false;
      upgrade = false;
    };

    taps = [
      "datawire/blackbird"   # telepresence (k8s)
      "metalbear-co/mirrord" # mirrord      (k8s)
      "minio/stable"         # mc (MinIO client)
      "nats-io/nats-tools"   # nats CLI
      "nikitabobko/tap"      # aerospace
    ];

    brews = [
      "colima"
      "context7-mcp"
      "docker"
      "docker-buildx"
      "docker-compose"
      "go-size-analyzer"
      "mariadb"
      "minio/stable/mc"
      "merve"
      "metalbear-co/mirrord/mirrord"
      "mise"
      "mole"
      "nats-io/nats-tools/nats"
      "nvm"
      "redis"
      "datawire/blackbird/telepresence"
    ];

    casks = [
      "nikitabobko/tap/aerospace"
      "android-studio"
      "bitwarden"
      "bruno"
      "claude-code@latest"
      "copilot-cli"
      "dbeaver-community"
      "font-meslo-lg-nerd-font"
      "ghostty"
      "keymapp"
      "obs"
      "obsidian"
      "raycast"
      "rectangle"
      "the-unarchiver"
      "visual-studio-code"
      "zen"
    ];
  };
}
