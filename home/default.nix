{ pkgs, ... }: {
  home.username = "ginolin980";
  home.homeDirectory = "/home/ginolin980";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    eww
    ghostty
    hyprpaper
    hypridle
    hyprlock
    fastfetch
    playerctl
    pamixer
    networkmanager
  ];

  imports = [
    ./hyprland.nix
    ./eww.nix
    ./ghostty.nix
    ./starship.nix
    ./nvim.nix
    ./zsh.nix
    ./fonts.nix
  ];

  programs.home-manager.enable = true;
}
