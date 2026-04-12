# Prevent PATH duplicates in nested shells
typeset -U PATH path

# Homebrew
[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

export XDG_CONFIG_HOME="$HOME/.config"
export NVM_DIR="$HOME/.nvm"

export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

ENV_PRIVATE_PATH="$HOME/.config/zsh/.zshenv_private"
[[ -f "$ENV_PRIVATE_PATH" ]] && source "$ENV_PRIVATE_PATH"
