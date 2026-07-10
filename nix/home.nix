{ config, lib, pkgs, user, local, ... }:

{
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
    sql-formatter
    kubectl
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

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    autosuggestion.enable = false;
    syntaxHighlighting.enable = false;

    history = {
      size = 50000;
      save = 50000;
      path = "$HOME/.zsh_history";
      ignoreAllDups = true;
      ignoreSpace = true;
      saveNoDups = true;
      share = true;
      extended = true;
    };

    envExtra = ''
      typeset -U PATH path
      [[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

      ENV_PRIVATE_PATH="$HOME/.config/zsh/.zshenv_private"
      [[ -f "$ENV_PRIVATE_PATH" ]] && source "$ENV_PRIVATE_PATH"
    '';

    initContent = ''
      _hm_zsh_autosuggestions="${pkgs.zsh-autosuggestions}/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
      _hm_zoxide="${pkgs.zoxide}/bin/zoxide"
      _hm_fzf_keybindings="${pkgs.fzf}/share/fzf/key-bindings.zsh"
      _hm_fzf_tab="${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh"
    '' + builtins.readFile ./zshrc.zsh;
  };

  home.file.".claude/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/claude/settings.json";

  home.file.".claude/CLAUDE.md".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/agents/AGENTS.md";

  home.activation.tmuxPlugins = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    TPM_DIR="$HOME/.tmux/plugins/tpm"
    if [ ! -d "$TPM_DIR" ]; then
      ${pkgs.git}/bin/git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM_DIR" \
        && TERM=xterm-256color PATH="${pkgs.tmux}/bin:$PATH" "$TPM_DIR/bin/install_plugins" \
        || echo "tmux TPM bootstrap incomplete; run 'prefix + I' in tmux later"
    fi
  '';
}
