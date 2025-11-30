#!/usr/bin/env bash

set -e

echo "🔧 Starting terminal environment installation…"

# -------------------------------
# 1. Install Homebrew if missing
# -------------------------------
if ! command -v brew &>/dev/null; then
    echo "🍺 Homebrew not found. Installing…"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "🍺 Homebrew already installed."
fi

# -------------------------------
# 2. Install dependencies
# -------------------------------
echo "📦 Installing dependencies…"
brew install starship zsh || true

# -------------------------------
# 3. Copy Starship config
# -------------------------------
mkdir -p ~/.config

STARSHIP_TARGET="$HOME/.config/starship.toml"
if [ -f "$STARSHIP_TARGET" ]; then
    echo "📁 Backing up existing starship.toml → starship.toml.backup"
    mv "$STARSHIP_TARGET" "$STARSHIP_TARGET.backup"
fi

echo "📁 Installing new starship.toml"
cp starship/starship.toml "$STARSHIP_TARGET"

# -------------------------------
# 4. Install .zshrc
# -------------------------------
ZSH_TARGET="$HOME/.zshrc"
if [ -f "$ZSH_TARGET" ]; then
    echo "📁 Backing up existing .zshrc → .zshrc.backup"
    mv "$ZSH_TARGET" "$ZSH_TARGET.backup"
fi

echo "📁 Installing new .zshrc"
cp zsh/zshrc "$ZSH_TARGET"

# -------------------------------
# 5. Ensure Starship config is set
# -------------------------------
if ! grep -q "export STARSHIP_CONFIG=" "$ZSH_TARGET"; then
    echo 'export STARSHIP_CONFIG="$HOME/.config/starship.toml"' >> "$ZSH_TARGET"
fi

# -------------------------------
# 6. Finished
# -------------------------------
echo "✨ Installation complete!"
echo "➡️  Restart your terminal or run:  source ~/.zshrc"
