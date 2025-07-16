# Configure open file
export PATH="$HOME/.local/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
ulimit -n 65535

# WSL specific configs
# if ! command -v wslview &> /dev/null 2>&1; then
#     sudo apt install wslu -y
# fi
# if ! command -v xdg-open &> /dev/null 2>&1; then
#     sudo apt install xdg-utils
# fi
# export BROWSER=wslview

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
    tree
    git
    xclip
    ansible
    curl
    wget
    docker
    docker-compose
    gnupg
    mpv
    htop
    bat
    lua
    ripgrep
    eza
    zoxide
    cmake
    gh
    inetutils
    mtr
    whois
    neovim
    diff-so-fancy
)

for pkg in "${BREW_DEPENDENCIES[@]}"; do
    if ! brew list --formula | grep -q "^$pkg\$"; then
        brew install "$pkg"
    fi
done

if ! command -v clab &> /dev/null 2>&1; then
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

# --- Auto-install Oh My Zsh Plugins if Missing ---
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
OMZ_PLUGINS_DIR="$ZSH_CUSTOM/plugins"
OMZ_GITHUB_PATH="https://github.com/zsh-users/"
OMZ_PLUGINS=(
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
)

for plugin in "${OMZ_PLUGINS[@]}"; do
    if [[ ! -d "$OMZ_PLUGINS_DIR/$plugin" ]]; then
        git clone --depth=1 "$OMZ_GITHUB_PATH/$plugin" "$OMZ_PLUGINS_DIR/$plugin"
    fi
done

BASE_PLUGINS=(git)
plugins=("${BASE_PLUGINS[@]}" "${OMZ_PLUGINS[@]}")

source $ZSH/oh-my-zsh.sh

CONFIG_DIR="$HOME/.zsh_scripts"

# Check if the directory exists and has at least one file
if [[ -d $CONFIG_DIR && -n ${CONFIG_DIR}/*(#qN) ]]; then
    for file in $CONFIG_DIR/*(.N); do
        source "$file"
    done
fi

# --- Oh-my-posh Installation ---
if ! command -v oh-my-posh &> /dev/null 2>&1; then
    curl -s https://ohmyposh.dev/install.sh | bash -s
fi

if ! command [ ! -e /home/huacc/.cargo/bin/tlrd ]; then
    brew install tlrc
    cargo install tlrc
fi
export PATH="$HOME/.cargo/bin/tlrd:$PATH"

# Ollama
# if ! command -v ollama &> /dev/null 2>&1; then
#     curl -fsSL https://ollama.com/install.sh | sh
# fi
# export OLLAMA_HOST=127.0.0.1:11430

if ! command -v poetry &> /dev/null 2>&1; then
    curl -sSL https://install.python-poetry.org | python3 -
    poetry self add poetry-plugin-shell
fi


eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/zen.toml)"

eval "$(zoxide init --cmd cd zsh)"
