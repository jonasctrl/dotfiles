{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = { nix-darwin, home-manager, nix-homebrew, ... }:
    let
      local =
        if builtins.pathExists ./local.nix then import ./local.nix
        else throw "nix/local.nix is missing - copy nix/local.nix.example to nix/local.nix and fill it in";
      user = local.user;
    in
    {
      darwinConfigurations."darwin" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit user local; };
        modules = [
          ./configuration.nix

          nix-homebrew.darwinModules.nix-homebrew

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-backup";
            home-manager.extraSpecialArgs = { inherit user local; };
            home-manager.users.${user} = import ./home.nix;
          }
        ];
      };
    };
}
