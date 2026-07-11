{ config, lib, pkgs, user, local, ... }:

{
  imports = [ ./modules/zsh.nix ];

  home.username = user;
  home.homeDirectory = "/Users/${user}";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    ripgrep
    fd
    fzf
    zoxide
    bat
    gh
    lazygit
    lazydocker
    neovim
    tree-sitter
    luarocks
    stylua
    prettier
    k9s
    btop
    htop
    most
    imagemagick
    graphviz
    nmap
    xh
    go
    golangci-lint
    gotools
    delve
    shfmt
    semgrep
    jq
    sd
    parallel
    tmux
    uv
    poetry
    pnpm
    nh
  ];

  home.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    GOPATH = "$HOME/go";
    NH_DARWIN_FLAKE = "path:$HOME/.config/nix#darwin";
  };

  home.sessionPath = [
    "$HOME/go/bin"
    "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  ];

  programs.git = {
    enable = true;
    settings.user.name = local.gitName;
    settings.user.email = local.gitEmail;
    ignores = [
      ".DS_Store"
      "._*"
      ".Trashes"
      ".vscode"
      ".idea"
      "*.swp"
      "*~"
      ".direnv/"
      ".claude"
      ".codegraph"
    ];
  };

  home.file.".claude/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/claude/settings.json";

  home.file.".claude/CLAUDE.md".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/agents/AGENTS.md";

  home.activation.tmuxPlugins = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    TPM_DIR="$HOME/.config/tmux/plugins/tpm"
    if [ ! -d "$TPM_DIR" ]; then
      ${pkgs.git}/bin/git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM_DIR" \
        && TERM=xterm-256color PATH="${pkgs.tmux}/bin:$PATH" "$TPM_DIR/bin/install_plugins" \
        || echo "tmux TPM bootstrap incomplete; run 'prefix + I' in tmux later"
    fi
  '';
}
