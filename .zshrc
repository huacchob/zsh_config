# Configure open file
ulimit -n 65535

# Detect the system
if [[ "$(uname -s)" == "Linux" ]]; then
    brew_path="/home/linuxbrew/.linuxbrew/bin/brew"
elif [[ "$(uname -s)" == "Darwin" ]]; then
    # Detect macOS architecture
    if [[ "$(uname -m)" == "arm64" ]]; then
        brew_path="/opt/homebrew/bin/brew"
    else
        brew_path="/usr/local/bin/brew"
    fi
fi

# --- Homebrew Setup ---
if [[ ! -e "$brew_path" ]]; then
    echo "Homebrew not found. Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Dynamically set brew path based on OS and architecture
if [[ -e $brew_path ]]; then
    eval "$($brew_path shellenv)"
fi

# Brew dependencies
BREW_DEPENDENCIES=(
    gcc
    git
    neovim
    ansible
    curl
    wget
    docker
    docker-compose
    gnupg
    mpv
    neovim
    htop
    bat
    lua
    ripgrep
    zsh-autocomplete
    zsh-completions
    zsh-syntax-highlighting
)

for pkg in "${BREW_DEPENDENCIES[@]}"; do
    if ! brew list --formula | grep -q "^$pkg\$"; then
        brew install "$pkg"
    fi
done

if [[ ! $(which clab) ]]; then
    bash -c "$(curl -sL https://get.containerlab.dev)"
fi


# Install meslo fonts
FONT_DIR="$HOME/.local/share/fonts"
FONT_CHECK="$FONT_DIR/MesloLGLNerdFontMono-Regular.ttf"
ZIP_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Meslo.zip"
ZIP_NAME="Meslo.zip"

# Check if the font is already installed
if [[ ! -f "$FONT_CHECK" ]]; then
    mkdir -p "$FONT_DIR" && \
        wget -q -P "$FONT_DIR" "$ZIP_URL" && \
        cd "$FONT_DIR" && \
        unzip -o "$ZIP_NAME" && \
        rm "$ZIP_NAME" && \
        if command -v fc-cache >/dev/null 2>&1; then
            fc-cache -fv "$FONT_DIR"
        fi
fi

export ZSH="$HOME/.oh-my-zsh"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

CONFIG_DIR="$HOME/.zsh_scripts"

# Check if the directory exists and has at least one file
if [[ -d $CONFIG_DIR && -n ${CONFIG_DIR}/*(#qN) ]]; then
    for file in $CONFIG_DIR/*(.N); do
        source "$file"
    done
fi

# --- Oh-my-posh Installation ---
if [[ ! $(which oh-my-posh) ]]; then
    curl -s https://ohmyposh.dev/install.sh | bash -s
fi
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/zen.toml)"
