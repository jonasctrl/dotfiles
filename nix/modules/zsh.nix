{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = false;

    envExtra = ''
      source "$HOME/.config/zsh/.zshenv"
    '';

    initContent = ''
      source "$HOME/.config/zsh/.zshrc"
    '';
  };
}
