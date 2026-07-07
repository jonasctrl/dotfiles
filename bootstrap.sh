#!/usr/bin/env bash
set -euo pipefail

FLAKE="path:$HOME/.config/nix#darwin"

if [ ! -e /nix/var/nix/profiles/default/bin/nix ]; then
  curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install --enable-flakes
fi
# shellcheck disable=SC1091
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

for f in bashrc zprofile zshrc nix/nix.conf; do
  [ -e "/etc/$f" ] && [ ! -L "/etc/$f" ] && sudo mv "/etc/$f" "/etc/$f.before-nix-darwin"
done

if [ ! -f "$HOME/.config/nix/local.nix" ]; then
  printf '{\n  user = "%s";\n  gitName = "";\n  gitEmail = "";\n}\n' "$(whoami)" > "$HOME/.config/nix/local.nix"
  echo "Created nix/local.nix from whoami; fill in gitName/gitEmail."
fi

sudo /nix/var/nix/profiles/default/bin/nix --extra-experimental-features "nix-command flakes" \
  run github:nix-darwin/nix-darwin/nix-darwin-26.05#darwin-rebuild -- \
  switch --flake "$FLAKE"
