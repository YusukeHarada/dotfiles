#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

link() {
  local src="$DOTFILES_DIR/$1"
  local dst="$HOME/$1"

  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mkdir -p "$BACKUP_DIR/$(dirname "$1")"
    mv "$dst" "$BACKUP_DIR/$1"
    echo "  backed up: $dst -> $BACKUP_DIR/$1"
  fi

  ln -sfn "$src" "$dst"
  echo "  linked:    $dst -> $src"
}

echo "==> Linking dotfiles from $DOTFILES_DIR"

link .zshrc
link .zprofile
link .gitconfig
link .gitignore_global
link .gitflow_export
link .hgignore_global
link .stCommitMsg
link .vimrc

echo "==> Linking .config entries"
mkdir -p "$HOME/.config"
link .config/gh
link .config/bat

echo "==> Linking VS Code settings"
VSCODE_DIR="$HOME/Library/Application Support/Code/User"
mkdir -p "$VSCODE_DIR"
VSCODE_SRC="$DOTFILES_DIR/vscode/settings.json"
VSCODE_DST="$VSCODE_DIR/settings.json"
if [ -e "$VSCODE_DST" ] && [ ! -L "$VSCODE_DST" ]; then
  mkdir -p "$BACKUP_DIR"
  mv "$VSCODE_DST" "$BACKUP_DIR/vscode_settings.json"
  echo "  backed up: $VSCODE_DST"
fi
ln -sfn "$VSCODE_SRC" "$VSCODE_DST"
echo "  linked:    $VSCODE_DST -> $VSCODE_SRC"

echo "==> Linking Claude Code settings"
mkdir -p "$HOME/.claude"
link .claude/settings.json

echo ""
echo "Done. Reload your shell: source ~/.zshrc"
