# Loaded by home-manager (nix/home.nix); the _hm_* vars are set there.

setopt INC_APPEND_HISTORY

ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
source "$_hm_zsh_autosuggestions"

autoload -Uz compinit
_comp_files=(${ZDOTDIR:-$HOME}/.zcompdump(Nm-20))
if (( $#_comp_files )); then
  compinit -i -C
else
  compinit -i
fi
unset _comp_files
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

load_nvm() {
  unset -f nvm node npm npx load_nvm 2>/dev/null
  [[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ]] && . "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
}
nvm()  { load_nvm; nvm "$@"; }
node() { load_nvm; command node "$@"; }
npm()  { load_nvm; command npm "$@"; }
npx()  { load_nvm; command npx "$@"; }

# Skip zoxide/fzf/etc for non-interactive and agent shells.
if [[ $- != *i* || "$CLAUDE_CODE" == "1" ]]; then
    return
fi

eval "$("$_hm_zoxide" init zsh)"
alias cd="z"

source "$_hm_fzf_keybindings"
bindkey -r '\ec'
bindkey -r '^T'

source "$_hm_fzf_tab"

_zsh_autosuggest_bind_widgets
