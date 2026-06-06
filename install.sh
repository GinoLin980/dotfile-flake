#!/usr/bin/env bash
# First-time setup script.
# Backs up any existing configs that would conflict, then applies the flake.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLAKE_TARGET="ginolin980"

echo "==> dotfile-flake: first-time install"
echo "    Dotfiles dir : $DOTFILES_DIR"
echo "    Flake target : $FLAKE_TARGET"
echo ""

# ── 1. Check Nix flakes are enabled ────────────────────────────────────────
if ! nix flake --version &>/dev/null; then
  echo "[ERROR] Nix flakes are not enabled."
  echo "        Add to /etc/nix/nix.conf:"
  echo "          experimental-features = nix-command flakes"
  exit 1
fi

# ── 2. Install Monocraft font (not in nixpkgs) ──────────────────────────────
FONT_SRC="$DOTFILES_DIR/monasm-dots/font/minecraft_font.ttc"
FONT_DST="$HOME/.local/share/fonts/minecraft_font.ttc"

if [ -f "$FONT_SRC" ] && [ ! -f "$FONT_DST" ]; then
  echo "==> Installing Monocraft font..."
  mkdir -p "$HOME/.local/share/fonts"
  cp "$FONT_SRC" "$FONT_DST"
  fc-cache -fv
  echo "    Done."
elif [ -f "$FONT_DST" ]; then
  echo "==> Monocraft font already installed, skipping."
else
  echo "    [WARN] Font not found at $FONT_SRC — install manually if needed."
fi

# ── 3. Apply home-manager with automatic backup ─────────────────────────────
# -b backup appends .backup to any conflicting existing files instead of failing.
echo ""
echo "==> Applying home-manager (existing configs will be renamed to *.backup)..."
nix run home-manager/master -- switch \
  --flake "$DOTFILES_DIR#$FLAKE_TARGET" \
  -b backup

# ── 4. Remind user to change default shell ──────────────────────────────────
CURRENT_SHELL="$(getent passwd "$USER" | cut -d: -f7)"
ZSH_PATH="$(command -v zsh 2>/dev/null || true)"

echo ""
if [ "$CURRENT_SHELL" != "$ZSH_PATH" ]; then
  echo "==> Your current shell is: $CURRENT_SHELL"
  echo "    To set zsh as default, run:"
  echo ""
  echo "      chsh -s $ZSH_PATH"
  echo ""
  echo "    Then log out and back in."
else
  echo "==> Default shell is already zsh."
fi

echo ""
echo "==> Install complete!"
echo "    Backed-up files (if any) are at their original path with .backup extension."
