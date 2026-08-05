{ pkgs, ... }:

{
  home.username = "user";
  home.homeDirectory = "/home/user";

  # Пользовательские приложения и инструменты разработки
  home.packages = with pkgs; [
    python3
    jetbrains-toolbox
    postgresql
    libreoffice
    telegram-desktop
    discord
    flameshot
    obsidian
    syncthing
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}