#!/usr/bin/env bash
set -e

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
)

echo "==> Installing required packages via pacman..."
sudo pacman -S --needed "${PACKAGES[@]}"

echo "==> Enabling SDDM display manager..."
sudo systemctl enable sddm.service

echo "==> Setting up directories..."
mkdir -p "$HOME/Media/Pictures/Wallpapers"
mkdir -p "$HOME/Pictures/Screenshots"
mkdir -p "$HOME/.local/bin"

# Keep Omarchy's runtime wallpaper link valid after wallpaper migrations.
mkdir -p "$HOME/.local/state/omarchy/current"
if [[ -f "$HOME/Pictures/wallpaper/wallpaper.png" ]]; then
    ln -sfn "$HOME/Pictures/wallpaper/wallpaper.png" "$HOME/.local/state/omarchy/current/background"
fi

echo "==> Ensuring script execute permissions..."
chmod +x "$HOME/Saint-system/stow/bin/.local/bin/"* 2>/dev/null || true
chmod +x "$HOME/Saint-system/stow/hypr/.config/hypr/scripts/"*.sh 2>/dev/null || true
chmod +x "$HOME/Saint-system/stow/hyprpaper/.config/hyprpaper/"*.sh 2>/dev/null || true
find "$HOME/Saint-system/stow/quickshell" \( -name "*.sh" -o -name "*.py" \) -exec chmod +x {} + 2>/dev/null || true

echo "==> Setup complete!"
