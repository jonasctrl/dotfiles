# Oh My Zsh configuration
ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="true"

# Install plugin if it doesn't exist
install_plugin() {
    local plugin_name="$1"
    local plugin_repo="$2"
    local plugin_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$plugin_name"
    
    if [[ ! -d "$plugin_dir" ]]; then
        echo "Installing $plugin_name..."
        git clone "$plugin_repo" "$plugin_dir"
        if [[ $? -eq 0 ]]; then
            echo "Successfully installed $plugin_name"
        else
            echo "Failed to install $plugin_name"
        fi
    fi
}

# Check and install external plugins
install_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"
install_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting"

plugins=(
    # Version control
    git
    
    # Development
    docker
    brew
    
    # Navigation & productivity
    z                          
    web-search                 
    copypath                  
    copyfile                   
    
    # Command enhancements
    colored-man-pages         
    command-not-found         
    sudo                    
    
    # Auto-installed external plugins
    zsh-autosuggestions       
    zsh-syntax-highlighting   
)

source $ZSH/oh-my-zsh.sh

# System shortcuts
alias reload="source ~/.zshrc" 

# History settings
export HISTSIZE=10000
export SAVEHIST=10000
setopt HIST_IGNORE_DUPS          # Don't record duplicates
setopt HIST_IGNORE_ALL_DUPS      # Delete old duplicate entries
setopt HIST_IGNORE_SPACE         # Don't record entries starting with space
setopt HIST_SAVE_NO_DUPS         # Don't write duplicates to history file
setopt SHARE_HISTORY             # Share history between terminals

# Auto-correction
setopt CORRECT                   # Enable command auto-correction
setopt CORRECT_ALL               # Enable argument auto-correction

# Completion settings
setopt COMPLETE_ALIASES         # Complete aliases
setopt COMPLETE_IN_WORD         # Complete from both ends of word
setopt ALWAYS_TO_END            # Move cursor to end after completion


[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
