#!/usr/bin/env bash
set -euo pipefail

exec sudo /run/current-system/sw/bin/darwin-rebuild switch \
  --flake "path:$HOME/.config/nix#darwin"
