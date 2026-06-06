{ pkgs, ... }: {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # nerd-fonts（nixpkgs 官方套件）
    nerd-fonts.jetbrains-mono   # 通用等寬，含完整圖示
    nerd-fonts.fira-code        # 有 ligature 的程式碼字型
    nerd-fonts.symbols-only     # 純圖示符號補丁（配任何字型使用）

    # Monacraft 由 monasm-dots 提供，需手動安裝：
    #   mkdir -p ~/.local/share/fonts
    #   cp ~/dotfiles/monasm-dots/font/minecraft_font.ttc ~/.local/share/fonts/
    #   fc-cache -fv
  ];
}
