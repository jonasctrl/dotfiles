# Git integration
autoload -Uz vcs_info add-zsh-hook
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%F{cyan}(%F{red}%b%F{cyan})%f'

precmd() { vcs_info }
setopt prompt_subst
PROMPT='%F{cyan}%~%f ${vcs_info_msg_0_} '

# History
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS SHARE_HISTORY

# Optimized completion
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
setopt COMPLETE_ALIASES COMPLETE_IN_WORD ALWAYS_TO_END

alias reload="source ~/.zshrc"

# Lazy-load NVM 
nvm() {
  unset -f nvm node npm npx
  [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && . "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
  nvm "$@"
}

node() { nvm; node "$@"; }
npm() { nvm; npm "$@"; }
npx() { nvm; npx "$@"; }
