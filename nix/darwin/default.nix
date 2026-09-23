{ user, local, ... }:

{
  imports = [
    ./homebrew.nix
    ./macos-defaults.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  system.stateVersion = 6;

  system.primaryUser = user;
  users.users.${user}.home = "/Users/${user}";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hm-backup";
  home-manager.overwriteBackup = true;
  home-manager.extraSpecialArgs = { inherit local; };
  home-manager.users.${user} = import ../home;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.channel.enable = false;

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 14d";
  };

  nix.optimise.automatic = true;

  programs.zsh.enable = true;
  programs.zsh.enableGlobalCompInit = false;
  programs.zsh.promptInit = "";

  # Expose zsh plugin files in /etc/profiles/per-user/<user>/share.
  environment.pathsToLink = [ "/share/fzf" "/share/fzf-tab" ];

  security.pam.services.sudo_local.touchIdAuth = true;
  security.pam.services.sudo_local.reattach = true;
}
