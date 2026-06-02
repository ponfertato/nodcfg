{ pkgs, ... }:
{
  environment.packages = with pkgs; [
    termux-api
    termux-tools
    ffmpeg
    python3
  ];
}
