autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%F{cyan}(%F{red}%b%F{cyan})%f'

precmd() { vcs_info }

setopt prompt_subst

PROMPT='%F{cyan}%~%f ${vcs_info_msg_0_} '

HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

autoload -Uz compinit
compinit -C
setopt COMPLETE_ALIASES
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

export NVM_DIR="$HOME/.nvm"
load_nvm() { [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; }
alias node="load_nvm; node"
alias npm="load_nvm; npm"
alias npx="load_nvm; npx"

alias reload="source ~/.zshrc"
