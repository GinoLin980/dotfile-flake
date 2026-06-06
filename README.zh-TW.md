# dotfile-flake

個人 dotfiles，以 **Nix Flakes** + **home-manager** 管理、**Git** 版控。
執行環境：**Arch Linux** + **Hyprland**。

---

> English version: [README.md](README.md)

---

## 這個 repo 裡有什麼

| 模組 | 說明 |
|------|------|
| `home/hyprland.nix` | Hyprland WM 設定 — 快捷鍵、動畫、視窗規則 |
| `home/ghostty.nix` | Ghostty 終端機 — Catppuccin Mocha 配色、Monocraft Nerd Font |
| `home/zsh.nix` | Zsh — zinit、fzf-tab、zoxide（接管 `cd`）、yazi（`y`）、lazygit |
| `home/eww.nix` | eww widget bar — 音量、電池、WiFi、音樂腳本 |
| `home/starship.nix` | Starship 提示符設定 |
| `home/nvim.nix` | Neovim — lazy.nvim 插件架構 |
| `home/fonts.nix` | Nerd Fonts（JetBrains Mono、Fira Code、Symbols Only） |

### Nix 管理的套件

```
eww  ghostty  hyprpaper  hypridle  hyprlock  fastfetch
playerctl  pamixer  networkmanager
zoxide  yazi  fzf  lazygit
nerd-fonts.jetbrains-mono  nerd-fonts.fira-code  nerd-fonts.symbols-only
```

### Zsh 插件（透過 zinit）

| 插件 | 來源 |
|------|------|
| zsh-autosuggestions | home-manager（nixpkgs，本地） |
| zsh-syntax-highlighting | home-manager（nixpkgs，本地） |
| fzf-tab | zinit → `Aloxaf/fzf-tab`（GitHub） |
| OMZ snippets | git, sudo, archlinux, command-not-found |

---

## 核心概念

### 為什麼用 Nix Flake？

傳統 dotfiles 靠 `stow` 或腳本 symlink 設定檔，但套件版本取決於系統狀態，不同機器可能裝出不同結果。

Nix Flake 的做法：

```
flake.lock  ←  鎖定所有套件的精確版本（commit hash 層級）
    ↓
任何機器執行相同指令 → 完全相同的環境
    ↓
每次 git commit = 一個可回溯的系統快照
```

### home-manager 的角色

- **Nix** 負責：下載、編譯、安裝套件
- **home-manager** 負責：把設定檔 symlink 到 `~/.config/`，管理 shell 整合

你在 `.nix` 檔案裡宣告「我要什麼」，home-manager 負責「把它放到對的地方」。

---

## 前置需求

- **Arch Linux**（或任何非 NixOS 的 Linux）
- **Nix**（已安裝並啟用 flakes）
- **Git**

### 確認 Nix flakes 已啟用

檢查 `/etc/nix/nix.conf` 是否包含：

```
experimental-features = nix-command flakes
```

---

## 第一次安裝

### 1. Clone 這個 repo

```bash
git clone git@github.com:GinoLin980/dotfile-flake.git ~/dotfiles
```

### 2. 安裝 Monocraft 字型（不在 nixpkgs 裡）

```bash
mkdir -p ~/.local/share/fonts
# 如果有 monasm-dots 的字型檔：
cp /path/to/minecraft_font.ttc ~/.local/share/fonts/
fc-cache -fv
```

### 3. 套用設定

```bash
nix run home-manager/master -- switch --flake ~/dotfiles#ginolin980
```

這一條指令會：
- 下載並建構所有宣告的套件
- 將設定檔 symlink 到 `~/.config/`
- 設定 shell 整合（zsh、fzf、zoxide 等）

> **第一次執行需要幾分鐘**，Nix 會從網路下載所有東西。之後的更新因為有快取會快很多。

### 4. 改預設 shell 為 zsh（Arch 需要手動執行一次）

```bash
chsh -s $(which zsh)
```

登出再登入後生效。

---

## 日常使用

### 修改設定後套用

```bash
# 編輯任何 .nix 檔後執行
home-manager switch --flake ~/dotfiles#ginolin980
```

### 提交並推送變更

```bash
cd ~/dotfiles
git add -p          # 逐一確認要提交的變更
git commit -m "..."
git push
```

### 在新機器上還原整個環境

```bash
# 先安裝 Nix，然後：
nix run home-manager/master -- switch --flake github:GinoLin980/dotfile-flake#ginolin980
```

一條指令，還原完整環境。

---

## 常用別名（定義於 zsh.nix）

| 別名 | 實際指令 | 說明 |
|------|---------|------|
| `lg` | lazygit | TUI git 介面 |
| `v` | nvim | 開啟 neovim |
| `y` | yazi wrapper | 開啟檔案管理器，離開時回到當前目錄 |
| `cd` | zoxide | 智慧跳轉（記憶常去目錄） |
| `ll` | `ls -lah --color` | 列出詳細檔案資訊 |

---

## 目錄結構

```
dotfiles/
├── flake.nix           # 入口 — 宣告 inputs（nixpkgs、home-manager）與 outputs
├── flake.lock          # 所有依賴的版本鎖定檔（git 追蹤）
├── home/
│   ├── default.nix     # 套件清單 + 模組 imports
│   ├── hyprland.nix    # Hyprland 設定
│   ├── ghostty.nix     # Ghostty 終端機設定
│   ├── zsh.nix         # Zsh + zinit + 工具整合
│   ├── eww.nix         # eww 設定（指向 eww-config/）
│   ├── eww-config/     # eww yuck/scss + 所有腳本
│   ├── starship.nix    # Starship 提示符
│   ├── nvim.nix        # Neovim（指向 nvim-config/）
│   ├── nvim-config/    # init.lua + lua/plugins/
│   └── fonts.nix       # 字型設定
└── README.md
```

---

## 版本回滾

Nix 的每次 `switch` 都會建立一個 **generation**，可以隨時回到上一個版本：

```bash
# 列出所有 generations
home-manager generations

# 切換到某個舊版本
home-manager switch --flake ~/dotfiles#ginolin980  # 搭配 git checkout 舊 commit
```

或直接用 git 回滾設定檔，再重新 switch。

---

## 致謝

- eww 設定改編自 [monasm-dots](https://github.com/Monasm/monasm-dots)
- Zsh 設定參考 [dreamsofautonomy/zensh](https://github.com/dreamsofautonomy/zensh)
