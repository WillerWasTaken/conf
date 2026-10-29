{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      podman-compose
      dive

      vagrant

      terraform
      terraform-docs
    ];
  };

  services = {
    podman.enable = true;
  };
}
