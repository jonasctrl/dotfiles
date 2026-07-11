#!/usr/bin/env bash
set -euo pipefail

FLAKE="path:$HOME/.config/nix"

# Xcode CLT provides cc, needed for nvim-treesitter parser compilation.
xcode-select -p >/dev/null 2>&1 || { xcode-select --install; echo "Install CLT."; exit 1; }

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
  echo "Created nix/local.nix from whoami; fill in gitName/gitEmail and re-run."
  exit 1
fi

if grep -q '= ""' "$HOME/.config/nix/local.nix"; then
  echo "nix/local.nix has empty fields; fill in gitName/gitEmail and re-run."
  exit 1
fi

# Build with the flake-locked nix-darwin, then activate with its own darwin-rebuild
# so the tool version always matches flake.lock.
/nix/var/nix/profiles/default/bin/nix --extra-experimental-features "nix-command flakes" \
  build "$FLAKE#darwinConfigurations.darwin.system" --out-link /tmp/bootstrap-system
sudo /tmp/bootstrap-system/sw/bin/darwin-rebuild switch --flake "$FLAKE#darwin"

/opt/homebrew/bin/mise install
