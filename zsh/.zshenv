export XDG_CONFIG_HOME="$HOME/.config"
export NVM_DIR="$HOME/.nvm"

export PATH=$PATH:/usr/local/go
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH=$PATH:$(go env GOPATH)/bin

ENV_PRIVATE_PATH="$HOME/.config/zsh/.zshenv_private"
if [ -f "$ENV_PRIVATE_PATH" ]; then
    source "$ENV_PRIVATE_PATH"
fi
