{ config, pkgs, lib, ... }:
lib.mkIf (!config.lib.helpers.isNixOS) {
  home = {
    file = with config.lib.helpers; {
      ".config/sway/config".source = configSymlink "sway/config";
    };
  };
}
