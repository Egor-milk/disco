{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Включаем поддержку Flakes на системном уровне
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Загрузчик UEFI
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Сеть и имя компьютера
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Региональные настройки
  time.timeZone = "Asia/Novosibirsk";
  i18n.defaultLocale = "ru_RU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Графическое окружение GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Переключение раскладки клавиатуры (Alt + Shift)
  services.xserver.xkb = {
    layout = "us,ru";
    variant = "";
    options = "grp:alt_shift_toggle";
  };

  # Звук (Pipewire) и печать (CUPS)
  services.printing.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Пользователь системы
  users.users."user" = {
    isNormalUser = true;
    description = "User";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  # Системные службы и программы
  virtualisation.docker.enable = true;
  programs.firefox.enable = true;
  programs.steam.enable = true;

  # Разрешаем установку unfree пакетов
  nixpkgs.config.allowUnfree = true;

  # Минимальные системные консольные утилиты
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
  ];

  system.stateVersion = "24.11";
}