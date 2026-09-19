{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      asdf-vm
      gnumake

      unzip
      tldr
      yq-go

      wl-clipboard

      # FS
      tree
      ncdu
      dust

      # Image
      tesseract
      imagemagick

      # Network
      traceroute
      tcpdump
      wget
      dig
      ipcalc
    ];
  };

  programs = {
    bat.enable = true;
    direnv.enable = true;
    fzf.enable = true;
    btop.enable = true;
    htop.enable = true;
    jq.enable = true;
    mise.enable = true;
    ripgrep.enable = true;
    opencode = {
      enable = true;
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
      package = pkgs.unstable.opencode;
    };
  };

  services = {
    udiskie = {
      enable = true;
      settings = {
          # workaround for
          # https://github.com/nix-community/home-manager/issues/632
          program_options = {
              # replace with your favorite file manager
              file_manager = "${pkgs.thunar}/bin/thunar";
          };
      };
    };
  };
}
