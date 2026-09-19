{ pkgs, ... }:
{
  # Configure gtk especially to set iconTheme, e.g pavucontrol using emblem-default not available in default gtk4
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus"; # or "Papirus-Dark"
      package = pkgs.papirus-icon-theme;
    };
  };

  home = {
    packages = with pkgs; [
      pavucontrol
      pamixer
    ];
  };

  services = {
    playerctld.enable = true;
  };
}
