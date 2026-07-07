{ user, ... }:

{
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = 6;

  system.primaryUser = user;
  users.users.${user}.home = "/Users/${user}";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
      "barutsrb/tap"
      "datawire/blackbird"
      "metalbear-co/mirrord"
      "minio/stable"
      "nats-io/nats-tools"
      "nikitabobko/tap"
      "tw93/tap"
    ];

    brews = [
      "colima"
      "context7-mcp"
      "docker"
      "docker-buildx"
      "docker-compose"
      "fileicon"
      "go-size-analyzer"
      "mariadb"
      "mise"
      "mole"
      "nvm"
      "redis"
      "rustup"
    ];

    casks = [
      "nikitabobko/tap/aerospace"
      "android-studio"
      "bitwarden"
      "bruno"
      "claude-code@latest"
      "copilot-cli"
      "dbeaver-community"
      "font-caskaydia-cove-nerd-font"
      "font-fira-code-nerd-font"
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
