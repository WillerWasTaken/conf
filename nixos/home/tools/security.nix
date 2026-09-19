{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      openssl
      wireguard-tools
      magic-wormhole

      yubikey-manager
    ];
  };

  programs = {
    gpg = {
      enable = true;
      scdaemonSettings = {
        disable-ccid = true;
      };
    };
    # Conflict with .ssh/config
    # ssh.enable = true;
  };

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      defaultCacheTtl = 30;
      maxCacheTtl = 60;
      maxCacheTtlSsh = 60;
      enableScDaemon = true;
      pinentry = {
        package = pkgs.pinentry-qt;
      };
    };
  };
}
