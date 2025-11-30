# Terminal Setup

A complete terminal environment configuration for developers, featuring a modern Zsh setup with Starship prompt and automated installation of essential development tools.

## Overview

This repository provides a streamlined setup for a productive terminal environment with:
- Custom Zsh configuration with Starship prompt
- Automated installation of development tools
- Clean, efficient prompt design with Gruvbox theming
- Node.js version management with fnm
- Essential global packages for modern web development

## Quick Start

1. Clone this repository:
```bash
git clone https://github.com/DavidDRea/terminal-setup.git
cd terminal-setup
```

2. Run the installer:
```bash
./install.sh
```

3. Restart your terminal to apply changes

## What Gets Installed

### Core Tools (Optional)
When you choose to install dependencies, the script will install:

**macOS (via Homebrew):**
- Git
- cURL
- Unzip
- Zsh
- Starship prompt
- fnm (Fast Node Manager)

**Linux (via apt):**
- Git, cURL, unzip, zip, Zsh
- Starship prompt
- fnm (Fast Node Manager)

### Node.js Environment
- Latest LTS Node.js version via fnm
- pnpm package manager
- Essential global npm/pnpm packages:
  - npm-check-updates
  - TypeScript & ts-node
  - ESLint & Prettier
  - Vercel CLI
  - Serverless Framework
  - PM2
  - http-server
  - Playwright (with browser installation)

### Configuration Files
- Custom `.zshrc` with optimized prompt setup
- Starship configuration with Gruvbox Dark theme

## Features

### Starship Prompt
- Beautiful Gruvbox Dark color scheme
- Programming language detection and version display
- Git branch and status indicators
- Directory path with smart truncation
- System information display
- Clean two-line prompt design

### Zsh Configuration
- fnm integration with automatic Node version switching
- Optimized prompt rendering without cursor blinking
- Homebrew path configuration for macOS
- NVM compatibility (if previously installed)

### Smart Installation
- Automatic platform detection (macOS/Linux)
- Backup of existing configuration files
- Optional dependency installation
- Error handling and validation

## File Structure

```
terminal-setup/
├── install.sh           # Main installation script
├── zsh/
│   └── zshrc            # Custom Zsh configuration
├── starship/
│   └── starship.toml    # Starship prompt configuration
└── tools/               # Reserved for additional tools
```

## Configuration Details

### Prompt Theme
The Starship configuration uses a custom Gruvbox Dark palette with the following elements:
- OS indicator with appropriate symbols
- Username display
- Current directory with icon substitutions
- Git branch and status
- Programming language versions (Node.js, Python, Rust, Go, etc.)
- Docker context and Conda environment
- Current time
- Two-line layout for clean command entry

### Zsh Features
- Fast Node Manager (fnm) with automatic version switching on directory change
- Starship prompt initialization
- Static arrow prompt on second line for consistent appearance
- Optimized for performance and visual stability

## Customization

### Modifying the Prompt
Edit `starship/starship.toml` to customize:
- Colors and theme
- Displayed modules
- Format and layout
- Programming language detection

### Extending Zsh Configuration
Edit `zsh/zshrc` to add:
- Custom aliases
- Additional environment variables
- Shell functions
- Plugin integrations

### Adding Tools
The `tools/` directory is available for additional scripts and utilities.

## Backup and Safety

The installer automatically backs up existing configuration files:
- `~/.zshrc` → `~/.zshrc.backup-{timestamp}`
- `~/.config/starship.toml` → `~/.config/starship.toml.backup-{timestamp}`

## Troubleshooting

### Common Issues

**fnm not working after installation:**
- Restart your terminal or run: `source ~/.zshrc`

**Starship not displaying correctly:**
- Ensure you have a Nerd Font installed in your terminal
- Check that `~/.config/starship.toml` exists

**Permission denied on install.sh:**
- Make the script executable: `chmod +x install.sh`

**Homebrew not found on macOS:**
- The installer will automatically install Homebrew if not present
- Ensure you have Xcode Command Line Tools installed

### Manual Installation

If the automated installer fails, you can manually:

1. Copy configuration files:
```bash
cp zsh/zshrc ~/.zshrc
mkdir -p ~/.config
cp starship/starship.toml ~/.config/starship.toml
```

2. Install Starship manually:
```bash
curl -sS https://starship.rs/install.sh | sh
```

3. Install fnm manually:
```bash
curl -fsSL https://fnm.vercel.app/install | bash
```

## Requirements

- Unix-like operating system (macOS, Linux)
- Bash or Zsh shell
- Internet connection for downloading tools
- Administrative privileges for package installation

## License

This project is open source and available under the MIT License.

## Contributing

Feel free to submit issues and enhancement requests. Contributions are welcome!

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

---

For questions or support, please open an issue on GitHub.