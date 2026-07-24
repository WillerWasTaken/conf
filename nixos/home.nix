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
  # wayland.windowManager.hyprland.systemd.enable = false;

  # Configure gtk especially to set iconTheme, e.g pavucontrol using emblem-default not available in default gtk4
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus"; # or "Papirus-Dark"
      package = pkgs.papirus-icon-theme;
    };
  };

  # Enable font discovery through home manager
  fonts.fontconfig.enable = true;

  home = {
    username = homeConfiguration.username;
    homeDirectory = homeConfiguration.homeDir;

    stateVersion = nixVersion;

    packages = with pkgs; [
      # kitty
      (writeShellScriptBin "kitty" ''
        exec ${nixgl.nixGLIntel}/bin/nixGLIntel ${kitty}/bin/kitty "$@"
      '')
      # For zsh completion
      systemd
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

      # Nvim
      ## LSP
      bash-language-server
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

      ## Treesitter
      tree-sitter

      # Azure
      kubelogin
      (azure-cli.withExtensions [ azure-cli.extensions.azure-devops azure-cli.extensions.rdbms-connect azure-cli.extensions.bastion azure-cli.extensions.ssh ])

      # Desktop (Wayland / Hyprland)
      # hyprlock
      # hypridle
      # hyprpaper
      # hyprlandPlugins.hy3
      waybar
      libnotify
      brightnessctl
      wdisplays
      # hyprprop
      grim
      slurp
      pavucontrol
      pamixer
      networkmanagerapplet

      # Graphical
      # pear-desktop
      (writeShellScriptBin "pear-desktop" ''
        exec ${nixgl.nixGLIntel}/bin/nixGLIntel ${pear-desktop}/bin/pear-desktop "$@"
      '')
      # https://github.com/NixOS/nixpkgs/issues/121694#issuecomment-2159420924
      # Disable apparmor
      (writeShellScriptBin "rambox" ''
        exec ${nixgl.nixGLIntel}/bin/nixGLIntel ${unstable.rambox}/bin/rambox "$@"
      '')
      # unstable.rambox
      # (config.lib.nixGL.wrap signal-desktop)
      (writeShellScriptBin "signal-desktop" ''
        exec ${nixgl.nixGLIntel}/bin/nixGLIntel ${signal-desktop}/bin/signal-desktop "$@"
      '')
      keepassxc
      pdfarranger
      netbird-ui
      brave
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
      ".config/kitty/zoom.py".source = configSymlink "kitty/zoom.py";
      # ".config/hypr/hyprland.lua".source = configSymlink "hypr/hyprland.lua";
      ".config/hypr/hyprlock.conf".source = configSymlink "hypr/hyprlock.conf";
      ".config/hypr/hypridle.conf".source = configSymlink "hypr/hypridle.conf";
      # ".config/uwsm/env-hyprland".text = ''
      #   export HY3_PLUGIN=${pkgs.hyprlandPlugins.hy3}/lib/libhy3.so
      #   # https://wiki.hypr.land/Configuring/Start/#autocompletions
      #   export HYPR_STUBS=${pkgs.hyprland}/share/hypr/stubs
      # '';
      ".config/sway/config".source = configSymlink "sway/config";
      ".config/waybar".source = configSymlink "waybar";
      ".config/kanshi/config".source = configSymlink "kanshi/config";
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
    gpg = {
      enable = true;
      scdaemonSettings = {
        disable-ccid = true;
      };
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
      # Do not handle init.lua file here
      sideloadInitLua = true;
      defaultEditor = true;
      package = pkgs.unstable.neovim-unwrapped;
    };
    opencode = {
      enable = true;
      # Will be available in 26-05 version
      skills = {
        caveman = (builtins.fetchGit {
          url = "https://github.com/juliusbrussee/caveman";
          ref = "main";
        }) + "/skills/caveman";
      };
      context = ''
        # Global Instructions

        At the start of every conversation, always invoke the caveman skill:
        skill({ name: "caveman" })

        Continue using the caveman style for all responses unless explicitly told to stop or use normal mode.
      '';
    };
    obsidian = {
      enable = true;
      defaultSettings = {
        appearance = {
          theme = "obsidian";
        };
      };
      vaults = {
        Second_Brain = {
          target = "vaults/Second Brain";
        };
      };
    };
    # Conflict with .ssh/config
    # ssh.enable = true;
    swappy = {
      enable = true;
      settings = {
        # https://github.com/jtheoof/swappy#config
        Default = {
          early_exit = true;
        };
      };
    };
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
    # hyprpaper = {
    #   enable = true;
    #   settings = {
    #     splash = false;
    #     wallpaper = [
    #       {
    #         # By default/fallback
    #         monitor = "";
    #         path = "~/.background-image";
    #       }
    #     ];
    #   };
    # };
    hypridle = {
      enable = true;
      # ConditionEnvironment=WAYLAND_DISPLAY was not met
      # systemdTarget = "default.target";
    };
    mako = {
      enable = true;
    };
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

  programs.home-manager.enable = true;
}
