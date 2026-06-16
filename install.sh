#!/bin/sh
set -e

PKGS="sway foot tmux rofi waybar mako ghostty jetbrains-mono-nerd-fonts"

echo "==> Installing packages..."
sudo dnf install -y $PKGS

if ! command -v nvim >/dev/null 2>&1; then
    echo "==> Installing Neovim..."
    sudo dnf install -y neovim
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "==> Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "==> Installing zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] ||
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ -d "$ZSH_CUSTOM/plugins/fast-syntax-highlighting" ] ||
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "==> Installing tpm..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
echo "==> Symlinking dotfiles from $SCRIPT_DIR..."
for f in $(cd "$SCRIPT_DIR" && find . -name .git -prune -o -type f -print | sed 's|^\./||'); do
    case "$f" in
        install.sh|.gitignore) continue ;;
    esac
    target="$HOME/$f"
    mkdir -p "$(dirname "$target")"
    ln -sf "$SCRIPT_DIR/$f" "$target"
done

echo "==> Installing tmux plugins..."
"$HOME/.tmux/plugins/tpm/bin/install_plugins" 2>/dev/null || true

echo "==> Installing Neovim plugins..."
nvim --headless "+qa" 2>/dev/null || true

echo "==> Done. Log out and back in for shell changes."
