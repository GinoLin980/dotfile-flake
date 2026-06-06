#!/usr/bin/env bash
# Daily-use script: apply current dotfiles and optionally commit + push changes.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLAKE_TARGET="ginolin980"

echo "==> dotfile-flake: applying changes..."

# ── Apply home-manager ──────────────────────────────────────────────────────
home-manager switch --flake "$DOTFILES_DIR#$FLAKE_TARGET"

echo ""
echo "==> Applied successfully."

# ── Optional: commit and push ───────────────────────────────────────────────
cd "$DOTFILES_DIR"

if [ -n "$(git status --porcelain)" ]; then
  echo ""
  echo "==> Uncommitted changes detected:"
  git status --short
  echo ""
  read -r -p "    Commit and push? [y/N] " answer
  if [[ "$answer" =~ ^[Yy]$ ]]; then
    read -r -p "    Commit message: " msg
    git add -A
    git commit -m "$msg"
    git push
    echo "==> Pushed to origin."
  else
    echo "    Skipped."
  fi
else
  echo "==> No uncommitted changes."
fi
