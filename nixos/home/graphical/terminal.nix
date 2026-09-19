{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      kitty
    ];
    file = with config.lib.helpers; {
      ".config/kitty/kitty.conf".source = configSymlink "kitty/kitty.conf";
      ".config/kitty/current-theme.conf".source = configSymlink "kitty/current-theme.conf";
      ".config/kitty/zoom.py".source = configSymlink "kitty/zoom.py";
    };
  };
  programs = {
    # Conflict with kitty conf file
    # kitty.enable = true;
    rofi = {
      enable = true;
      theme = "solarized_alternate";
      extraConfig = {
        terminal = "kitty";
      };
    };
  };
}
