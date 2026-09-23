# dotfiles

macOS config via nix-darwin + home-manager + nix-homebrew.

Apply changes:
```
nh darwin switch --impure
```

Update flake inputs:
```
nh darwin switch -u --impure
```

Bootstrap nix-darwin and home-manager with:
```
~/.config/bootstrap.sh
```
