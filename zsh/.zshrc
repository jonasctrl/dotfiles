HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"

HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS SHARE_HISTORY

# Plugins
source ${(q-)HOME}/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Completion 
autoload -Uz compinit
_comp_files=(${ZDOTDIR:-$HOME}/.zcompdump(Nm-20))
if (( $#_comp_files )); then
  compinit -i -C
else
  compinit -i
fi
unset _comp_files

setopt COMPLETE_ALIASES COMPLETE_IN_WORD ALWAYS_TO_END

# Git prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%F{cyan}(%F{red}%b%F{cyan})%f'
zstyle ':vcs_info:git:*' actionformats '%F{cyan}(%F{yellow}%b%F{cyan})%f'

precmd() { vcs_info }
setopt prompt_subst
PROMPT='%F{cyan}%~%f ${vcs_info_msg_0_} '

# Lazy-load NVM
nvm() {
  unset -f nvm node npm npx
  [[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ]] && . "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
  nvm "$@"
}
node() { nvm; node "$@"; }
npm() { nvm; npm "$@"; }
npx() { nvm; npx "$@"; }

# Aliases
alias reload="exec zsh"
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias grep='grep --color=auto'

alias glog='git log --pretty=format:"%h - %an, %ar : %s" --abbrev-commit'

# Zoxide 
eval "$(zoxide init zsh)"
