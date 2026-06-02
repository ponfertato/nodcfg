{ pkgs, lib, ... }:
{
  system.stateVersion = lib.mkDefault "24.05";

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "ru_RU.UTF-8";

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      connect-timeout = 5;
      download-attempts = 3;
      fallback = true;
      http-connections = 16;
      stalled-download-timeout = 30;
      substituters = [
        "https://mirror.yandex.ru/nixos/?priority=5"
        "https://cache.nixos.org/?priority=10"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  terminal.shell = "${pkgs.bashInteractive}/bin/bash";

  environment.packages = with pkgs; [
    bashInteractive
    coreutils-full
    curl
    fd
    git
    htop
    jq
    lazygit
    nano
    openssh
    ripgrep
    rsync
    tree
    unzip
    wget
  ];
}
