# Loaded by home-manager (nix/home.nix); the _hm_* vars are set there.

# Skip interactive setup for non-interactive and agent shells.
if [[ $- != *i* || "$CLAUDE_CODE" == "1" ]]; then
    return
fi

setopt INC_APPEND_HISTORY

ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
source "$_hm_zsh_autosuggestions"

autoload -Uz compinit
_comp_dump="${ZDOTDIR:-$HOME}/.zcompdump-$ZSH_VERSION"
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
PROMPT='%F{cyan}%~%f ${vcs_info_msg_0_} '

alias reload="exec zsh"
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias grep='grep --color=auto'
alias glog='git log --pretty=format:"%h - %an, %ar : %s" --abbrev-commit'

eval "$(mise activate zsh)"

eval "$("$_hm_zoxide" init zsh --cmd cd)"

source "$_hm_fzf_keybindings"
bindkey -r '\ec'
bindkey -r '^T'

source "$_hm_fzf_tab"

_zsh_autosuggest_bind_widgets
