{ user, ... }:

{
  imports = [
    ./modules/homebrew.nix
    ./modules/macos-defaults.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = 6;

  system.primaryUser = user;
  users.users.${user}.home = "/Users/${user}";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 14d";
  };

  nix.optimise.automatic = true;

  programs.zsh.enable = true;
  programs.zsh.enableGlobalCompInit = false;

  security.pam.services.sudo_local.touchIdAuth = true;
}
