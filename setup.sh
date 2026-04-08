#!/bin/bash
set -e

DOTFILES="$HOME/.config"

info() { printf "\033[1;34m[info]\033[0m %s\n" "$1"; }
ok()   { printf "\033[1;32m[ok]\033[0m   %s\n" "$1"; }
warn() { printf "\033[1;33m[warn]\033[0m %s\n" "$1"; }

# 1. Homebrew
if ! command -v brew &>/dev/null; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ok "Homebrew installed"
else
    ok "Homebrew already installed"
fi

# 2. Brew bundle (taps, formulae, casks, vscode extensions)
if [[ -f "$DOTFILES/homebrew/Brewfile" ]]; then
    info "Installing Homebrew packages from Brewfile..."
    brew bundle --file="$DOTFILES/homebrew/Brewfile" || warn "Some packages failed to install — check output above"
    ok "Homebrew packages done"
else
    warn "No Brewfile found at $DOTFILES/homebrew/Brewfile — skipping"
fi

# 3. ZSH symlinks
link() {
    local src="$1" dst="$2"
    if [[ -L "$dst" ]]; then
        if [[ "$(readlink "$dst")" == "$src" ]]; then
            ok "Already linked: $dst -> $src"
            return
        fi
        rm "$dst"
    elif [[ -e "$dst" ]]; then
        warn "Backing up existing $dst to ${dst}.bak"
        mv "$dst" "${dst}.bak"
    fi
    ln -s "$src" "$dst"
    ok "Linked: $dst -> $src"
}

info "Setting up ZSH symlinks..."
link "$DOTFILES/zsh/.zshrc"  "$HOME/.zshrc"
link "$DOTFILES/zsh/.zshenv" "$HOME/.zshenv"

# 4. ZSH plugins (git clones)
ZSH_PLUGIN_DIR="$DOTFILES/zsh/plugins"
mkdir -p "$ZSH_PLUGIN_DIR"

clone_plugin() {
    local repo="$1" dir="$ZSH_PLUGIN_DIR/$(basename "$repo")"
    if [[ -d "$dir" ]]; then
        ok "ZSH plugin already installed: $(basename "$repo")"
    else
        info "Cloning ZSH plugin: $repo..."
        git clone "https://github.com/$repo.git" "$dir"
        ok "Installed ZSH plugin: $(basename "$repo")"
    fi
}

clone_plugin "zsh-users/zsh-autosuggestions"

# 5. TPM + tmux plugins
TPM_DIR="$HOME/.tmux/plugins/tpm"

if [[ -d "$TPM_DIR" ]]; then
    ok "TPM already installed"
else
    info "Installing TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    ok "TPM installed"
fi

info "Installing tmux plugins..."
"$TPM_DIR/bin/install_plugins" || warn "Could not install tmux plugins (is tmux running?)"
ok "Tmux plugins installed"

echo ""
info "Setup complete! Run 'exec zsh' to reload your shell."

# NOTE: Quick manual steps for linking .config to a git repo.
# cd ~
# git clone git@github.com:YOUR_USER/dotfiles.git .config-dotfiles
# mv .config-dotfiles/.git .config/
# cd .config
# git checkout .
