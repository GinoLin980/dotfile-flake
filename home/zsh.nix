{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      save = 10000;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };

    initExtra = ''
      # ── zinit bootstrap ────────────────────────────────────────────
      source ${pkgs.zinit}/share/zinit/zinit.zsh

      # zinit annexes
      zinit light-mode for \
        zdharma-continuum/zinit-annex-as-monitor \
        zdharma-continuum/zinit-annex-bin-gem-node \
        zdharma-continuum/zinit-annex-patch-dl \
        zdharma-continuum/zinit-annex-rust

      # ── OMZ snippets (inspired by zensh) ───────────────────────────
      zinit snippet OMZP::git
      zinit snippet OMZP::sudo
      zinit snippet OMZP::archlinux
      zinit snippet OMZP::command-not-found

      # ── fzf-tab (must load BEFORE autosuggestions) ─────────────────
      zinit light Aloxaf/fzf-tab

      # replay completions collected during above loads
      zinit cdreplay -q

      # ── keybindings ────────────────────────────────────────────────
      bindkey "^[[A" history-search-backward
      bindkey "^[[B" history-search-forward
      bindkey "^[w"  kill-region

      # ── completion styling (zensh-inspired) ────────────────────────
      zstyle ':completion:*'           matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*'           list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*'           menu no
      zstyle ':fzf-tab:complete:cd:*'  fzf-preview 'yazi --cwd-file=/dev/null "$realpath" 2>/dev/null || ls --color $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

      # ── tool integrations ──────────────────────────────────────────
      eval "$(zoxide init --cmd cd zsh)"

      # yazi shell wrapper — sets CWD on exit with `y`
      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }
    '';

    shellAliases = {
      ls   = "ls --color";
      ll   = "ls -lah --color";
      la   = "ls -A --color";
      ".." = "cd ..";
      "..."= "cd ../..";
      lg   = "lazygit";
      v    = "nvim";
      c    = "clear";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [
      "--height 40%"
      "--layout=reverse"
      "--border"
      "--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8"
      "--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc"
      "--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
    ];
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = false;  # 手動 init 以便用 --cmd cd 覆蓋預設 z
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = false;  # 手動定義 y() wrapper 以保留 CWD
  };

  home.packages = with pkgs; [
    lazygit
  ];
}
