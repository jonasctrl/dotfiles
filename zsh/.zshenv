typeset -U PATH path
[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# NOTE: must stay after brew shellenv so mise-managed tools beat brew
# duplicates (e.g. a brew formula pulling in node) in non-interactive shells.
path=("$HOME/.local/share/mise/shims" $path)

export XDG_CONFIG_HOME="$HOME/.config"
export GOPATH="$HOME/go"
path=("$HOME/go/bin" $path)
path+=("/Applications/Visual Studio Code.app/Contents/Resources/app/bin")

ENV_PRIVATE_PATH="$HOME/.config/zsh/.zshenv_private"
[[ -f "$ENV_PRIVATE_PATH" ]] && source "$ENV_PRIVATE_PATH"
