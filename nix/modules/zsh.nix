{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = false;

    envExtra = ''
      source "$HOME/.config/zsh/.zshenv"
    '';

    initContent = ''
      ZSH_AUTOSUGGESTIONS_SRC="${pkgs.zsh-autosuggestions}/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
      FZF_TAB_SRC="${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh"
      FZF_SHARE="${pkgs.fzf}/share/fzf"

      source "$HOME/.config/zsh/.zshrc"
    '';
  };
}
