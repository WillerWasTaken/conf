# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, systemConfiguration, homeConfiguration, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Wayland environment variables
  environment.variables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    XDG_CURRENT_DESKTOP = "Hyprland";
    WLR_NO_HARDWARE_CURSORS = "1";  # needed for NVIDIA
  };
  # Use localtime just like windows for dual boot
  # https://nixos.wiki/wiki/Dual_Booting_NixOS_and_Windows
  time.hardwareClockInLocalTime = true;

  # Bootloader
  boot = {
    kernelPackages = pkgs.linuxPackages_6_18;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = systemConfiguration.hostname; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = systemConfiguration.timeZone;

  # Select internationalization properties.
  i18n.defaultLocale = systemConfiguration.defaultLocale;

  i18n.extraLocaleSettings = with systemConfiguration; {
    LC_ADDRESS = extraLocale;
    LC_IDENTIFICATION = extraLocale;
    LC_MEASUREMENT = extraLocale;
    LC_MONETARY = extraLocale;
    LC_NAME = extraLocale;
    LC_NUMERIC = extraLocale;
    LC_PAPER = extraLocale;
    LC_TELEPHONE = extraLocale;
    LC_TIME = extraLocale;
  };

  # Enable device mounting
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Hyprland (Wayland)
  programs.hyprland = {
    enable = true;
    # Recommended way to launch Hyprland, notably triggers the graphical-session systemd target properly
    withUWSM = true;
  };

  # Login manager (regreet via greetd + cage)
  programs.regreet = {
    enable = true;
    settings = {
      GTK.application_prefer_dark_theme = true;
    };
  };
  # regreet module enables greetd automatically, override session command to launch Hyprland
  services.greetd.settings.default_session.command = let
    hyprlandConfig = pkgs.writeText "greetd-hyprland-config" ''
      exec-once = ${pkgs.regreet}/bin/regreet; hyprctl dispatch exit
    '';
  in "${pkgs.hyprland}/bin/Hyprland --config ${hyprlandConfig}";

  # XDG portal for screen sharing, file dialogs, etc.
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  security.polkit.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound
  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${homeConfiguration.username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Willer";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  nix = {
    # Clean automatically old builds
    gc = {
      automatic = true;
      randomizedDelaySec = "14m";
      options = "--delete-older-than 7d";
    };

    # Enable flakes
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim-full
  ];

  programs.zsh = {
    enable = true;
  };

  programs.nm-applet.enable = true;
  programs.thunar.enable = true;
  services.tumbler.enable = true; # Thumbnail support for images in thunar

  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
      # For Nixos version > 22.11
      #defaultNetwork.settings = {
      #  dns_enabled = true;
      #};
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = systemConfiguration.nixVersion; # Did you read the comment?
}
