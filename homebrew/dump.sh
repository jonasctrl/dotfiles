#!/bin/bash
brew bundle dump --file="$(dirname "$0")/Brewfile" --force
echo "Brewfile updated at $(dirname "$0")/Brewfile"
