{ config, pkgs, nixVersion, homeConfiguration, ... }:

let
  mkMutableSymlink =  dir: path: config.lib.file.mkOutOfStoreSymlink (dir + "/" + path);

  dotfileSymlink = path: mkMutableSymlink homeConfiguration.dotfilesDir path;
  configSymlink = path: mkMutableSymlink homeConfiguration.configDir path;
  scriptSymlink = path: mkMutableSymlink homeConfiguration.scriptsDir path;
in {
  home.username = homeConfiguration.username;
  home.homeDirectory = homeConfiguration.homeDir;

  home.stateVersion = nixVersion;

  # Enable font discovery through home manager
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    kitty
    python3
    asdf-vm
    zplug
    nerdfonts

    qgit
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
    yq
    tcpdump
    ipcalc
    ncdu
    magic-wormhole
    wireguard-tools

    pavucontrol
    pamixer
    arandr
    polybarFull
    dunst

    krew
    kubectl
    kubectx
    kconf
    kubernetes-helm
    kind

    terraform
    terraform-docs

    # Azure
    kubelogin
    azure-cli

    youtube-music
    unstable.rambox
    keepassxc
    flameshot
    pdfarranger
  ];

  programs.autorandr.enable = true;
  programs.direnv.enable = true;
  programs.firefox.enable = true;
  programs.chromium.enable = true;
  programs.fzf.enable = true;
  programs.git.enable = true;
  programs.go.enable = true;
  programs.htop.enable = true;
  programs.jq.enable = true;
  programs.k9s.enable = true;
  # Conflict with kitty conf file
  # programs.kitty.enable = true;
  programs.ripgrep.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      # LSP
      lua-language-server
      gopls
      ansible-language-server
      terraform-ls
      nodePackages.bash-language-server
      python3Packages.python-lsp-server
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

  home.file = {
    ".vimrc".source = dotfileSymlink "vimrc";
    ".p10k.zsh".source = dotfileSymlink "p10k.zsh";
    ".gitconfig".source = dotfileSymlink "gitconfig";
    ".zshrc".source = dotfileSymlink "zshrc";

    ".config/kitty/kitty.conf".source = configSymlink "kitty/kitty.conf";
    ".config/kitty/current-theme.conf".source = configSymlink "kitty/current-theme.conf";
    ".config/i3/config".source = configSymlink "i3/config";
    ".config/polybar".source = configSymlink "polybar";
    ".config/dunst".source = configSymlink "dunst";
    ".config/nvim".source = configSymlink "nvim";

    "tools/scripts/lock.sh".source = scriptSymlink "lock.sh";
  };

  programs.home-manager.enable = true;
}
