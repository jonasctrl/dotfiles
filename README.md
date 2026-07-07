# dotfiles (nix-darwin)

macOS config via nix-darwin + home-manager + nix-homebrew.
Apply any change with:
```
`~/.config/rebuild.sh`
```

## Find package names
- brew: `brew search [--cask] <term>`
- nix:  `nix search nixpkgs <term>` (or search.nixos.org)

## Update versions
- everything: `nix flake update`
- one input:  `nix flake update nixpkgs` | `nix-homebrew`
- brew apps:  not upgraded on switch, but could be temporary upgraded `brew upgrade`

## Capture a macOS UI change
```sh
defaults read > /tmp/a          # before
defaults read > /tmp/b          # after
diff /tmp/a /tmp/b              # shows domain + key + value
```
Add it to `system.defaults.<domain>` (or `system.defaults.CustomUserPreferences."<domain>".<key>`).
