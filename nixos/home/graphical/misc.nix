{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      pdfarranger
      keepassxc
      (writeShellScriptBin "pear-desktop" ''
        exec ${nixgl.nixGLIntel}/bin/nixGLIntel ${pear-desktop}/bin/pear-desktop "$@"
      '')
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
