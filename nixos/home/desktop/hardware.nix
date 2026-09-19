{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      networkmanagerapplet
    ];
  };

  services = {
    blueman-applet.enable = true;
  };
}
