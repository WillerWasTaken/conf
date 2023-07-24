{ config, pkgs, nixVersion, homeConfiguration, ... }:

let
  mkMutableSymlink =  dir: path: config.lib.file.mkOutOfStoreSymlink (dir + "/" + path);

  dotfileSymlink = path: mkMutableSymlink homeConfiguration.dotfilesDir path;
  configSymlink = path: mkMutableSymlink homeConfiguration.configDir path;
in {
  home.username = homeConfiguration.username;
  home.homeDirectory = homeConfiguration.homeDir;

  home.stateVersion = nixVersion;

  home.packages = with pkgs; [
    kitty
    python3
    asdf-vm
    zplug

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

    spotify
    unstable.rambox
    keepassxc
    flameshot

    # NUMSPOT
    nodejs
    vault
    gcc
    awscli2
    gnupg
    pinentry-curses
    onedrive
    chromium
    talosctl
    vcluster
    cfssl
    age
  ];

  programs.autorandr.enable = true;
  programs.direnv.enable = true;
  programs.firefox.enable = true;
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

  home.file = {
    ".vimrc".source = dotfileSymlink "vimrc";
    ".p10k.zsh".source = dotfileSymlink "p10k.zsh";
    ".gitconfig".source = dotfileSymlink "gitconfig";
    ".zshrc".source = dotfileSymlink "zshrc";

    ".config/kitty/kitty.conf".source = configSymlink "kitty/kitty.conf";
    ".config/i3/config".source = configSymlink "i3/config";
    ".config/polybar".source = configSymlink "polybar";
    ".config/dunst".source = configSymlink "dunst";
    ".config/nvim".source = configSymlink "nvim";
  };

  programs.home-manager.enable = true;
}
