{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = false;

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

      # NOTE: must stay after brew shellenv so mise-managed tools beat brew
      # duplicates (e.g. a brew formula pulling in node) in non-interactive shells.
      path=("$HOME/.local/share/mise/shims" $path)

      ENV_PRIVATE_PATH="$HOME/.config/zsh/.zshenv_private"
      [[ -f "$ENV_PRIVATE_PATH" ]] && source "$ENV_PRIVATE_PATH"
    '';

    initContent = ''
      # Skip interactive setup for non-interactive and agent shells.
      if [[ $- != *i* || "$CLAUDE_CODE" == "1" ]]; then
          return
      fi

      setopt INC_APPEND_HISTORY

      ZSH_AUTOSUGGEST_MANUAL_REBIND=1
      ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
      source "${pkgs.zsh-autosuggestions}/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

      autoload -Uz compinit
      _comp_dump="''${ZDOTDIR:-$HOME}/.zcompdump-$ZSH_VERSION"
      _comp_files=($_comp_dump(Nm-20))
      if (( $#_comp_files )); then
        compinit -i -C -d "$_comp_dump"
      else
        compinit -i -d "$_comp_dump"
      fi
      unset _comp_files _comp_dump
      setopt COMPLETE_ALIASES COMPLETE_IN_WORD ALWAYS_TO_END

      autoload -Uz vcs_info
      zstyle ':vcs_info:*' enable git
      zstyle ':vcs_info:git:*' formats '%F{cyan}(%F{red}%b%F{cyan})%f'
      zstyle ':vcs_info:git:*' actionformats '%F{cyan}(%F{yellow}%b%F{cyan})%f'
      precmd() { vcs_info }
      setopt prompt_subst
      PROMPT='%F{cyan}%~%f ''${vcs_info_msg_0_} '

      alias reload="exec zsh"
      alias ls='ls --color=auto'
      alias ll='ls -lah --color=auto'
      alias grep='grep --color=auto'
      alias glog='git log --pretty=format:"%h - %an, %ar : %s" --abbrev-commit'

      eval "$(mise activate zsh)"

      eval "$("${pkgs.zoxide}/bin/zoxide" init zsh --cmd cd)"

      source "${pkgs.fzf}/share/fzf/key-bindings.zsh"
      bindkey -r '\ec'
      bindkey -r '^T'

      source "${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh"

      _zsh_autosuggest_bind_widgets
    '';
  };
}
