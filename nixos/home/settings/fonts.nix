{ pkgs, ...}:
{
  # Enable font discovery through home manager
  fonts.fontconfig.enable = true;

  home = {
    packages = builtins.filter pkgs.lib.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  };
}
