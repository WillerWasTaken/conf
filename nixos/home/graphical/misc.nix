{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      pdfarranger
      keepassxc
      pear-desktop
    ];
  };
  programs = {
    obsidian = {
      enable = true;
      defaultSettings = {
        appearance = {
          theme = "obsidian";
        };
      };
      vaults = {
        Second_Brain = {
          target = "vaults/Second Brain";
        };
      };
    };
  };
}
