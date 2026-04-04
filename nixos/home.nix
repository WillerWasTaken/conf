{ config, pkgs, nixVersion, homeConfiguration, ... }:

let
  mkMutableSymlink =  dir: path: config.lib.file.mkOutOfStoreSymlink (dir + "/" + path);

  dotfileSymlink = path: mkMutableSymlink homeConfiguration.dotfilesDir path;
  configSymlink = path: mkMutableSymlink homeConfiguration.configDir path;
  assetsSymlink = path: mkMutableSymlink homeConfiguration.assetsDir path;
in {
  nix = {
    gc = {
      automatic = true;
      randomizedDelaySec = "14m";
      options = "--delete-older-than 7d";
    };
  };

  # Not to conflict with hyprland using UWSM
  # https://wiki.hypr.land/Useful-Utilities/Systemd-start/
  wayland.windowManager.hyprland.systemd.enable = false;

  # Enable font discovery through home manager
  fonts.fontconfig.enable = true;

  home = {
    username = homeConfiguration.username;
    homeDirectory = homeConfiguration.homeDir;

    stateVersion = nixVersion;

    packages = with pkgs; [
      kitty
      python3
      asdf-vm
      zplug

      # Cmd
      wget
      gnumake
      unzip
      tldr
      dig
      openssl
      imagemagick
      wl-clipboard
      tree
      yq-go
      tcpdump
      ipcalc
      ncdu
      dust
      magic-wormhole
      wireguard-tools
      tesseract

      # database
      dbeaver-bin
      postgresql
      # mssql
      azuredatastudio

      # Devops
      podman-compose
      dive
      terraform
      terraform-docs
      krew
      kubectl
      kubectx
      kconf
      kubernetes-helm
      kind

      # Language
      cargo
      cargo-watch
      rustc
      clang

      # Azure
      kubelogin
      (azure-cli.withExtensions [ azure-cli.extensions.azure-devops azure-cli.extensions.bastion azure-cli.extensions.ssh ])

      # Desktop (Wayland / Hyprland)
      hyprlock
      hyprprop
      hypridle
      hyprpaper
      wdisplays
      waybar
      mako
      libnotify
      brightnessctl
      grim
      slurp
      pavucontrol
      pamixer
      networkmanagerapplet

      # Graphical
      youtube-music
      unstable.rambox
      signal-desktop
      keepassxc
      flameshot
      pdfarranger
      # To handle through programs.obsidian.enable = true when 25.11 will be out
      obsidian
    ] ++ builtins.filter pkgs.lib.isDerivation (builtins.attrValues pkgs.nerd-fonts);

    file = {
      ".vimrc".source = dotfileSymlink "vimrc";
      ".p10k.zsh".source = dotfileSymlink "p10k.zsh";
      ".gitconfig".source = dotfileSymlink "gitconfig";
      ".zshrc.manual".source = dotfileSymlink "zshrc";
      ".kubectl_aliases".source = builtins.fetchurl {
        url = https://raw.githubusercontent.com/ahmetb/kubectl-aliases/refs/heads/master/.kubectl_aliases;
      };

      ".config/kitty/kitty.conf".source = configSymlink "kitty/kitty.conf";
      ".config/kitty/current-theme.conf".source = configSymlink "kitty/current-theme.conf";
      ".config/hypr".source = configSymlink "hypr";
      ".config/waybar".source = configSymlink "waybar";
      ".config/mako/config".source = configSymlink "mako/config";
      ".config/nvim".source = configSymlink "nvim";

      ".background-image".source = assetsSymlink "hou-china-6.jpg";
      ".lock.png".source = assetsSymlink "rick_and_morty_lock.png";
    };
  };

  programs = {
    bat.enable = true;
    direnv.enable = true;
    delta = {
      enable = true;
      enableGitIntegration = true;
    };
    firefox.enable = true;
    chromium.enable = true;
    fzf.enable = true;
    git = {
      enable = true;
      package = pkgs.gitFull;
    };
    lazygit = {
      enable = true;
      settings = {
        git = {
          # Show all branches on git log
          log = {
            showGraph = "always";
            showWholeGraph = true;
          };
          # set delta
          # https://github.com/jesseduffield/lazygit/blob/master/docs/Custom_Pagers.md#delta
          pagers = [{
            pager =  "delta --dark --paging=never";
          }];
        };
      };
    };
    go.enable = true;
    btop.enable = true;
    htop.enable = true;
    jq.enable = true;
    k9s.enable = true;
    # Conflict with kitty conf file
    # kitty.enable = true;
    mise.enable = true;
    ripgrep.enable = true;
    rofi = {
      enable = true;
      theme = "solarized_alternate";
      extraConfig = {
        terminal = "kitty";
      };
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      package = pkgs.unstable.neovim-unwrapped;
      extraPackages = with pkgs; [
        # LSP
        nodePackages.bash-language-server
        docker-compose-language-service
        dockerfile-language-server
        gopls
        harper
        jq-lsp
        vscode-langservers-extracted
        lua-language-server
        nginx-language-server
        python3Packages.python-lsp-server
        rust-analyzer
        terraform-ls

        # Treesitter
        tree-sitter
      ];
    };
    opencode = {
      enable = true;
    };
    # obsidian = {
    #   enable = true;
    # };
    # Conflict with .ssh/config
    # ssh.enable = true;
    zsh = {
      enable = true;
      sessionVariables = {
        ZPLUG_DIR = "${pkgs.zplug}/share/zplug";
        FZF_DIR = "${config.programs.fzf.package}/share/fzf";
        ASDF_DIR = "${pkgs.asdf-vm}/share/asdf-vm";
      };
      initContent = pkgs.lib.mkOrder 1500 ''
        source ~/.zshrc.manual
      '';
    };
  };

  # systemd.user.services.onedrive = {
  #   Unit = {
  #     Description = "Sync onedrive.";
  #   };
  #   Service = {
  #     ExecStart = "${pkgs.onedrive}/bin/onedrive --monitor";
  #   };
  # };

  services = {
    blueman-applet.enable = true;
    playerctld.enable = true;
    kanshi.enable = true;
  };

  programs.home-manager.enable = true;
}
