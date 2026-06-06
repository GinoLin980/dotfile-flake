{ ... }: {
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "Monocraft Nerd Font";
      font-size = 13;
      cursor-style = "block";
      mouse-hide-while-typing = true;
      background-opacity = 0.95;
      # catppuccin mocha palette（搭配 monasm-dots 配色）
      background = "1e1e2e";
      foreground = "cdd6f4";
    };
  };
}
