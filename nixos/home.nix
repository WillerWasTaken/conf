{ config, pkgs, nixVersion, homeConfiguration, ... }:

let
  mkMutableSymlink =  dir: path: config.lib.file.mkOutOfStoreSymlink (dir + "/" + path);

  dotfileSymlink = path: mkMutableSymlink homeConfiguration.dotfilesDir path;
  configSymlink = path: mkMutableSymlink homeConfiguration.configDir path;
  assetsSymlink = path: mkMutableSymlink homeConfiguration.assetsDir path;
in {
  home.username = homeConfiguration.username;
  home.homeDirectory = homeConfiguration.homeDir;

  home.stateVersion = nixVersion;
  nix = {
    gc = {
      automatic = true;
      randomizedDelaySec = "14m";
      options = "--delete-older-than 7d";
    };
  };

  xsession = {
    enable = true;
  };
  home.keyboard = {
    layout = homeConfiguration.kbLayout;
    variant = homeConfiguration.kbVariant;
  };

  # Enable font discovery through home manager
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
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
    scrot
    xsel
    tree
    yq-go
    tcpdump
    ipcalc
    ncdu
    magic-wormhole
    wireguard-tools

    # Devops
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
    azure-cli
    azuredatastudio

    # Desktop
    i3lock-color
    pavucontrol
    pamixer
    arandr
    polybarFull
    dunst

    # Graphical
    youtube-music
    unstable.rambox
    signal-desktop
    keepassxc
    flameshot
    pdfarranger
  ] ++ builtins.filter pkgs.lib.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  programs.autorandr.enable = true;
  programs.bat.enable = true;
  programs.direnv.enable = true;
  programs.firefox.enable = true;
  programs.chromium.enable = true;
  programs.fzf.enable = true;
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
  };
  programs.go.enable = true;
  programs.htop.enable = true;
  programs.jq.enable = true;
  programs.k9s.enable = true;
  # Conflict with kitty conf file
  # programs.kitty.enable = true;
  programs.ripgrep.enable = true;
  programs.rofi = {
    enable = true;
    theme = "solarized_alternate";
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      # LSP
      ansible-language-server
      nodePackages.bash-language-server
      docker-compose-language-service
      dockerfile-language-server-nodejs
      gopls
      jq-lsp
      vscode-langservers-extracted
      lua-language-server
      nginx-language-server
      python3Packages.python-lsp-server
      rust-analyzer
      terraform-ls
    ];
  };
  # Conflict with .ssh/config
  # programs.ssh.enable = true;
  programs.zsh = {
    enable = true;
    sessionVariables = {
      ZPLUG_DIR = "${pkgs.zplug}/share/zplug";
      FZF_DIR = "${config.programs.fzf.package}/share/fzf";
      ASDF_DIR = "${pkgs.asdf-vm}/share/asdf-vm";
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

  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;
  services.picom.enable = true;
  services.playerctld.enable = true;

  home.file = {
    ".vimrc".source = dotfileSymlink "vimrc";
    ".p10k.zsh".source = dotfileSymlink "p10k.zsh";
    ".gitconfig".source = dotfileSymlink "gitconfig";
    ".zshrc".source = dotfileSymlink "zshrc";
    ".kubectl_aliases".source = builtins.fetchurl {
      url = https://raw.githubusercontent.com/ahmetb/kubectl-aliases/refs/heads/master/.kubectl_aliases;
    };

    ".config/kitty/kitty.conf".source = configSymlink "kitty/kitty.conf";
    ".config/kitty/current-theme.conf".source = configSymlink "kitty/current-theme.conf";
    ".config/i3/config".source = configSymlink "i3/config";
    ".config/polybar".source = configSymlink "polybar";
    ".config/dunst".source = configSymlink "dunst";
    ".config/nvim".source = configSymlink "nvim";

    ".background-image".source = assetsSymlink "hou-china-6.jpg";
    ".lock.png".source = assetsSymlink "rick_and_morty_lock.png";
  };

  programs.home-manager.enable = true;
}
