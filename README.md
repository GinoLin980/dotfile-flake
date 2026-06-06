# dotfile-flake

My personal dotfiles managed with **Nix Flakes** + **home-manager**, version-controlled with Git.
Running on **Arch Linux** with **Hyprland**.

---

> 中文說明請見 [README.zh-TW.md](README.zh-TW.md)

---

## What's Inside

| Module | Description |
|--------|-------------|
| `home/hyprland.nix` | Hyprland WM config — keybinds, animations, window rules |
| `home/ghostty.nix` | Ghostty terminal — Catppuccin Mocha, Monocraft Nerd Font |
| `home/zsh.nix` | Zsh — zinit, fzf-tab, zoxide (`cd`), yazi (`y`), lazygit |
| `home/eww.nix` | eww widget bar — scripts for vol, battery, wifi, music |
| `home/starship.nix` | Starship prompt config |
| `home/nvim.nix` | Neovim — lazy.nvim plugin structure |
| `home/fonts.nix` | Nerd Fonts (JetBrains Mono, Fira Code, Symbols Only) |

### Packages managed by Nix

```
eww  ghostty  hyprpaper  hypridle  hyprlock  fastfetch
playerctl  pamixer  networkmanager
zoxide  yazi  fzf  lazygit
nerd-fonts.jetbrains-mono  nerd-fonts.fira-code  nerd-fonts.symbols-only
```

### Zsh plugins (via zinit)

| Plugin | Source |
|--------|--------|
| zsh-autosuggestions | home-manager (nixpkgs) |
| zsh-syntax-highlighting | home-manager (nixpkgs) |
| fzf-tab | zinit → `Aloxaf/fzf-tab` |
| OMZ snippets | git, sudo, archlinux, command-not-found |

---

## Requirements

- **Arch Linux** (or any non-NixOS Linux)
- **Nix** with flakes enabled
- **Git**

### Enable Nix flakes (if not already)

Add to `/etc/nix/nix.conf`:

```
experimental-features = nix-command flakes
```

---

## First-time Setup

### 1. Clone this repo

```bash
git clone git@github.com:GinoLin980/dotfile-flake.git ~/dotfiles
```

### 2. Install Monocraft font (not in nixpkgs)

```bash
mkdir -p ~/.local/share/fonts
# if you have the monasm-dots font file:
cp /path/to/minecraft_font.ttc ~/.local/share/fonts/
fc-cache -fv
```

### 3. Apply the configuration

```bash
nix run home-manager/master -- switch --flake ~/dotfiles#ginolin980
```

This command:
- Downloads and builds all declared packages
- Symlinks config files into `~/.config/`
- Sets up shell integrations

> **First run takes several minutes** — Nix is downloading and building everything.

### 4. Set Zsh as default shell (one-time, Arch only)

```bash
chsh -s $(which zsh)
```

Log out and back in for it to take effect.

---

## Day-to-day Usage

### Apply changes after editing a config

```bash
home-manager switch --flake ~/dotfiles#ginolin980
```

### Commit and push changes

```bash
cd ~/dotfiles
git add -p          # review what changed
git commit -m "..."
git push
```

### On a new machine

```bash
# install Nix first, then:
nix run home-manager/master -- switch --flake github:GinoLin980/dotfile-flake#ginolin980
```

---

## Useful Aliases (set in zsh.nix)

| Alias | Command |
|-------|---------|
| `lg` | lazygit |
| `v` | nvim |
| `y` | yazi (cd on exit) |
| `cd` | zoxide (smart jump) |
| `ll` | `ls -lah --color` |

---

## Directory Structure

```
dotfiles/
├── flake.nix           # entry point — inputs & outputs
├── flake.lock          # pinned dependency versions
├── home/
│   ├── default.nix     # package list + module imports
│   ├── hyprland.nix
│   ├── ghostty.nix
│   ├── zsh.nix
│   ├── eww.nix
│   ├── eww-config/     # eww yuck/scss + scripts
│   ├── starship.nix
│   ├── nvim.nix
│   ├── nvim-config/    # init.lua + lua/plugins/
│   └── fonts.nix
└── README.md
```

---

## Credits

- eww config adapted from [monasm-dots](https://github.com/Monasm/monasm-dots)
- Zsh config inspired by [dreamsofautonomy/zensh](https://github.com/dreamsofautonomy/zensh)
