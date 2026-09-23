{ user, ... }:

{
  nix-homebrew = {
    enable = true;
    inherit user;
    autoMigrate = true;
    enableZshIntegration = false;
  };

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      # IMPORTANT: Brew is not snapshotted; every switch updates and upgrades to latest.
      autoUpdate = true;
      upgrade = true;
      # Activation drops XDG_CONFIG_HOME, which splits brew tap trust between two files.
      extraEnv.XDG_CONFIG_HOME = "/Users/${user}/.config";
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
      "docker"
      "docker-buildx"
      "docker-compose"
      "go-size-analyzer"
      "mariadb"
      "minio/stable/mc"
      "merve"
      "metalbear-co/mirrord/mirrord"
      "mole"
      "nats-io/nats-tools/nats"
      "redis"
      "datawire/blackbird/telepresence"
    ];

    casks = [
      "nikitabobko/tap/aerospace"
      "android-studio"
      "bitwarden"
      "bruno"
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
