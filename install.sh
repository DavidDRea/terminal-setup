#!/usr/bin/env bash

set -e

echo "Dotfiles Installer"
echo "----------------------"
echo ""
echo "This script can:"
echo "  • Install developer tools (zsh, fnm, node, pnpm, git, playwright, unzip)"
echo "  • Install global npm & pnpm packages"
echo "  • Copy your .zshrc and starship.toml to the correct locations"
echo ""
read -p "Do you want to install developer dependencies? (y/N): " INSTALL_DEPS

INSTALL_DEPS=$(echo "$INSTALL_DEPS" | tr '[:upper:]' '[:lower:]')

# ---------------------------
# OPTIONAL: Install Dependencies
# ---------------------------
if [[ "$INSTALL_DEPS" == "y" || "$INSTALL_DEPS" == "yes" ]]; then
    echo ""
    echo "Installing developer tools..."

    # Detect platform
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macOS detected"
        if ! command -v brew >/dev/null 2>&1; then
            echo "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi

        brew install \
            git \
            curl \
            unzip \
            zsh \
            starship \
            fnm

    else
        echo "🐧 Linux detected"

        if command -v apt >/dev/null 2>&1; then
            sudo apt update
            sudo apt install -y \
                git \
                curl \
                unzip \
                zip \
                zsh

            curl -sS https://starship.rs/install.sh | sh -s -- -y
            curl -fsSL https://fnm.vercel.app/install | bash
        else
            echo "Unsupported Linux distro — skipping dependency installation."
        fi
    fi

    # ---------------------------
    # Install Node via fnm
    # ---------------------------
    if command -v fnm >/dev/null 2>&1; then
        echo "Installing Node (LTS) using fnm..."

        # Load fnm environment
        eval "$(fnm env --shell bash 2>/dev/null || fnm env --shell zsh)"

        fnm install --lts
        fnm default lts-latest

        echo "Node installed successfully."

        # ---------------------------
        # Install pnpm
        # ---------------------------
        echo "Installing pnpm..."
        corepack enable
        corepack prepare pnpm@latest --activate

        echo "Installing global npm packages..."
        GLOBAL_PACKAGES=(
            npm-check-updates
            typescript
            ts-node
            eslint
            prettier
            vercel
            serverless
            pm2
            http-server
        )

        npm install -g "${GLOBAL_PACKAGES[@]}"

        echo "Installing global pnpm packages..."
        pnpm add -g "${GLOBAL_PACKAGES[@]}"

        # ---------------------------
        # Install Playwright
        # ---------------------------
        echo "Installing Playwright browsers..."
        pnpm add -g playwright
        playwright install
        playwright install-deps || true
    else
        echo "fnm not found — skipping Node, pnpm, npm global installs, and Playwright setup."
    fi

    echo ""
    echo "Developer tools installed."
else
    echo "Skipping dependency installation."
fi


# ---------------------------
# Config propagation
# ---------------------------

echo ""
echo "Syncing configuration files…"

mkdir -p ~/.config
mkdir -p ~/.config/starship

backup_file() {
    if [[ -f "$1" ]]; then
        echo "Backing up $1 → $1.backup-$(date +%s)"
        mv "$1" "$1.backup-$(date +%s)"
    fi
}

backup_file ~/.zshrc
backup_file ~/.config/starship.toml

cp ./zsh/zshrc ~/.zshrc
cp ./starship/starship.toml ~/.config/starship.toml

echo "Config files synced!"
echo ""

echo "Installation Complete!"
echo "Restart terminal to apply changes."
echo ""
