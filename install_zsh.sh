#! bin/bash

set -e

# Check if Zsh is installed
if ! command -v zsh >/dev/null 2>&1; then
  # Update and install Zsh
  sudo apt update
  sudo apt install -y zsh
fi

if [[ "$SHELL" != "$(command -v zsh)" ]]; then
  chsh -s "$(command -v zsh)"
fi

# Only install if ~/.oh-my-zsh doesn't exist
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  # Install without auto-switching shell or overwriting .zshrc
  RUNZSH=no KEEP_ZSHRC=yes \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
