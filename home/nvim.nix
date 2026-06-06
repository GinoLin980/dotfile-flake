{ ... }: {
  # nvim 設定以目錄方式管理，保留 lazy.nvim 的 init.lua 結構
  # 實際 plugin 設定放在 home/nvim-config/ 目錄下
  xdg.configFile."nvim" = {
    source = ./nvim-config;
    recursive = true;
  };
}
