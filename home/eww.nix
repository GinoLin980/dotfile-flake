{ ... }: {
  # eww 設定檔直接從 home/eww-config/ 目錄 symlink 到 ~/.config/eww/
  # 把 monasm-dots/.config/eww/ 的內容複製到 home/eww-config/ 後即可生效
  xdg.configFile."eww" = {
    source = ./eww-config;
    recursive = true;
  };
}
