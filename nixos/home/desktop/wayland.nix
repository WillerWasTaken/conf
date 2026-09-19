{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      waybar
      wdisplays

      grim
      slurp
      brightnessctl

      libnotify
    ];

    file = with config.lib.helpers; {
      ".config/waybar".source = configSymlink "waybar";
      ".config/kanshi/config".source = configSymlink "kanshi/config";
      ".config/mako/config".source = configSymlink "mako/config";

      ".config/hypr/hyprlock.conf".source = configSymlink "hypr/hyprlock.conf";
      ".lock.png".source = assetsSymlink "rick_and_morty_lock.png";

      ".background-image".source = assetsSymlink "hou-china-6.jpg";
    };
  };

  programs = {
    swappy = {
      enable = true;
      settings = {
        # https://github.com/jtheoof/swappy#config
        Default = {
          early_exit = true;
        };
      };
    };
  };

  services = {
    hypridle = {
      enable = true;
    };
    kanshi.enable = true;
    mako = {
      enable = true;
    };
  };
}
