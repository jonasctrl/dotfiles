HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY HIST_FCNTL_LOCK

# NOTE: Skip interactive setup for non-interactive and agent shells.
if [[ $- != *i* || "$CLAUDECODE" == "1" ]]; then
    return
fi

# NOTE: EDITOR=nvim would otherwise make zsh start in vi mode.
bindkey -e

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

autoload -Uz compinit
_comp_dump="${ZDOTDIR:-$HOME}/.zcompdump-$ZSH_VERSION"
_comp_files=($_comp_dump(Nmh-24))
if (( $#_comp_files )); then
  compinit -i -C -d "$_comp_dump"
else
  compinit -i -d "$_comp_dump"
  # NOTE: compinit only rewrites a valid dump when completions change.
  touch "$_comp_dump"
fi
unset _comp_files _comp_dump
setopt COMPLETE_ALIASES COMPLETE_IN_WORD ALWAYS_TO_END
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*:descriptions' format '[%d]'
# NOTE: No zsh menu, so fzf-tab can insert the common prefix first.
zstyle ':completion:*' menu no

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

FZF_CTRL_T_COMMAND=
FZF_ALT_C_COMMAND=
_source_first \
  "$_nix_share/fzf/key-bindings.zsh" \
  "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

_source_first \
  "$_nix_share/fzf-tab/fzf-tab.plugin.zsh" \
  "$_brew_share/fzf-tab/fzf-tab.plugin.zsh"

ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
_source_first \
  "$_nix_share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  "$_brew_share/zsh-autosuggestions/zsh-autosuggestions.zsh"

unset -f _source_first
unset _nix_share _brew_share
