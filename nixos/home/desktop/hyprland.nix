{ config, pkgs, lib, ... }:
lib.mkIf config.lib.helpers.isNixOS {
  # Not to conflict with hyprland using UWSM
  # https://wiki.hypr.land/Useful-Utilities/Systemd-start/
  wayland.windowManager.hyprland.systemd.enable = false;

  home = {
    packages = with pkgs; [
      hyprlandPlugins.hy3
      hyprprop
      hyprpaper

      hyprlock
    ];
    file = with config.lib.helpers; {
      ".config/hypr/hyprland.lua".source = configSymlink "hypr/hyprland.lua";
      ".config/uwsm/env-hyprland".text = ''
        export HY3_PLUGIN=${pkgs.hyprlandPlugins.hy3}/lib/libhy3.so
        # https://wiki.hypr.land/Configuring/Start/#autocompletions
        export HYPR_STUBS=${pkgs.hyprland}/share/hypr/stubs
      '';
    };
  };

  services = {
    hyprpaper = {
      enable = true;
      settings = {
        splash = false;
        wallpaper = [
          {
            # By default/fallback
            monitor = "";
            path = "~/.background-image";
          }
        ];
      };
    };
  };
}
