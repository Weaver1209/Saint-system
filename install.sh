#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STOW_DIR="$DOTFILES_DIR/stow"

# Package list required by Saint-system dotfiles
PACKAGES=(
    sddm
    stow
    inotify-tools
    hyprpaper
    quickshell
    ghostty
    rofi
    wlogout
    starship
    tmux
    zsh
    eza
    bat
    zoxide
    fzf
    fd
    jq
    grim
    slurp
    wl-clipboard
    brightnessctl
    playerctl
    libnotify
    wireplumber
    ttf-jetbrains-mono-nerd
    qt6ct
    openconnect
    networkmanager-openconnect
)

# Check if packages need installation
if command -v pacman &>/dev/null; then
    MISSING_PKGS=()
    for pkg in "${PACKAGES[@]}"; do
        if ! pacman -Q "$pkg" &>/dev/null; then
            MISSING_PKGS+=("$pkg")
        fi
    done

    if [ ${#MISSING_PKGS[@]} -gt 0 ]; then
        echo "==> Missing packages detected: ${MISSING_PKGS[*]}"
        echo "==> Installing missing packages via pacman..."
        sudo pacman -S --needed --noconfirm "${MISSING_PKGS[@]}" 2>/dev/null || sudo pacman -S --needed "${MISSING_PKGS[@]}"
    else
        echo "==> All required packages are already installed."
    fi
else
    echo "Warning: pacman not found, skipping package installation."
fi

echo "==> Checking SDDM display manager..."
if command -v systemctl &>/dev/null; then
    if ! systemctl is-enabled sddm.service &>/dev/null; then
        echo "==> Enabling SDDM display manager..."
        sudo systemctl enable sddm.service 2>/dev/null || true
    else
        echo "==> SDDM display manager already enabled."
    fi
fi

echo "==> Setting up target directories..."
mkdir -p "$HOME/Media/Pictures/Wallpapers"
mkdir -p "$HOME/Pictures/Screenshots"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.config"

echo "==> Ensuring script execute permissions..."
chmod +x "$STOW_DIR/bin/.local/bin/"* 2>/dev/null || true
chmod +x "$STOW_DIR/hypr/.config/hypr/scripts/"*.sh 2>/dev/null || true
chmod +x "$STOW_DIR/hyprpaper/.config/hyprpaper/"*.sh 2>/dev/null || true
chmod +x "$STOW_DIR/aether/.config/aether/bin/"* 2>/dev/null || true
chmod +x "$STOW_DIR/aether/.config/aether/custom/"*/*.sh 2>/dev/null || true
find "$STOW_DIR/quickshell" \( -name "*.sh" -o -name "*.py" \) -exec chmod +x {} + 2>/dev/null || true

echo "==> Stowing packages to $HOME..."
for pkg_path in "$STOW_DIR"/*; do
    if [ -d "$pkg_path" ]; then
        pkg="$(basename "$pkg_path")"
        echo "  -> Stowing $pkg..."
        stow -d "$STOW_DIR" -t "$HOME" --adopt -R "$pkg"
    fi
done

echo "==> Reloading systemd user services..."
if command -v systemctl &>/dev/null; then
    systemctl --user daemon-reload 2>/dev/null || true
    systemctl --user enable --now walt-aether.path 2>/dev/null || true
    systemctl --user enable --now walt-aether-sync.timer 2>/dev/null || true
fi

echo "==> Setup complete!"

