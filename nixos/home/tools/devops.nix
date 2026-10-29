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
    # Issue with ubuntu
    # podman = {
    #   enable = true;
    # };
  };
}
