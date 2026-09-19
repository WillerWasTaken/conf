{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      podman-compose
      dive

      terraform
      terraform-docs
    ];
  };

  services = {
    podman.enable = true;
  };
}
