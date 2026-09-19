{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      brave
    ];
  };
  programs = {
    firefox.enable = true;
    chromium.enable = true;
  };
}
