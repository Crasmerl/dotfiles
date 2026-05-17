# Crasmerl - Dotfiles

Personal configuration files for my Arch Linux setup with Hyprland. Feel free to take inspiration or use anything you find useful.

Use at your own risk.

![Screenshot](./screenshot.png)

## Setup

```bash
mkdir -p ~/dev/config
git clone https://github.com/Crasmerl/dotfiles.git ~/dev/config/dotfiles
cd ~/dev/config/dotfiles
./install.sh
```

The install script creates symlinks automatically and backs up any existing configs to `~/.dotfiles_backup/`.

## Requirements

- zsh + oh-my-zsh
- Hyprland
- Waybar
- Kitty or Ghostty
- Neovim (NvChad)
- fastfetch
- eww
- wofi
- swaync
- btop
- thefuck
- zellij
- git

## What's Included

| Folder | Description |
|---|---|
| **hypr/** | Hyprland, hyprlock, hypridle, hyprpaper |
| **waybar/** | Status bar config and styles |
| **eww/** | Widgets (music player) and scripts |
| **nvim/** | Neovim config with NvChad and plugins |
| **kitty/** | Kitty terminal config and theme |
| **ghostty/** | Ghostty terminal config |
| **fastfetch/** | System info on terminal launch with custom logo |
| **zsh/** | Zshrc, aliases and themes for Linux and macOS |
| **btop/** | System monitor config with Tokyo Night theme |
| **wofi/** | App launcher config and styles |
| **swaync/** | Notification center styles |
| **thefuck/** | Shell correction tool settings |
| **zellij/** | Terminal multiplexer layouts and config |
| **vscode/** | VSCode and Cursor settings and keybindings |
| **git/** | Global git config |
| **bin/** | Utility scripts |
| **cursor/** | Cursor editor desktop entry and icon |
