{ user, ... }:

{
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
