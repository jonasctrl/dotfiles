HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY EXTENDED_HISTORY HIST_FCNTL_LOCK

# NOTE: Skip interactive setup for non-interactive and agent shells.
if [[ $- != *i* || "$CLAUDE_CODE" == "1" ]]; then
    return
fi

setopt INC_APPEND_HISTORY

# NOTE: Plugins are found wherever they are installed.
_source_first() {
  local f
  for f in "$@"; do
    [[ -r "$f" ]] && { source "$f"; return 0; }
  done
  return 1
}
_nix_share="/etc/profiles/per-user/$USER/share"
_brew_share="/opt/homebrew/share"

ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
_source_first \
  "$_nix_share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  "$_brew_share/zsh-autosuggestions/zsh-autosuggestions.zsh"

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

source "$HOME/.config/zsh/.zsh_profile"

eval "$(mise activate zsh)"
eval "$(zoxide init zsh --cmd cd)"

_source_first \
  "$_nix_share/fzf/key-bindings.zsh" \
  "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
bindkey -r '\ec'
bindkey -r '^T'

_source_first \
  "$_nix_share/fzf-tab/fzf-tab.plugin.zsh" \
  "$_brew_share/fzf-tab/fzf-tab.plugin.zsh"

(( $+functions[_zsh_autosuggest_bind_widgets] )) && _zsh_autosuggest_bind_widgets

unset -f _source_first
unset _nix_share _brew_share
