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
      mtr
    ];
  };

  programs = {
    bat.enable = true;
    direnv.enable = true;
    eza = {
      enable = true;
      colors = "always";
      icons = "always";
      git = true;
    };
    fzf.enable = true;
    btop.enable = true;
    htop.enable = true;
    jq.enable = true;
    mise.enable = true;
    ripgrep.enable = true;
    mcp = {
      enable = true;
      servers = {
        clickup = {
          url = "https://mcp.clickup.com/mcp";
          # OAuth is handled automatically by opencode
        };
      };
    };
    opencode = {
      enable = true;
      # enableMcpIntegration = true;
      skills = {
        caveman = (builtins.fetchGit {
          url = "https://github.com/juliusbrussee/caveman";
          ref = "main";
        }) + "/skills/caveman";
        clickup = ''
          ---
          name: clickup
          description: Defaults ClickUp - Workspace PSI Infra, Space SRE, List SRE.
                       Charger avant création/modification de tickets ClickUp.
          ---

          # ClickUp Defaults

          ## Configuration
          - **Workspace**: PSI Infra (ID: 90120103118)
          - **Space**: SRE
          - **List**: SRE (ID: 901221173659)

          ## Usage
          Charger ce skill avant toute opération ClickUp pour appliquer les défaults
          skill({ name: "clickup" })

          ## Notes
          - Ne s'applique qu'après chargement explicite
          - Uniquement pour l'espace SRE / PSI Infra

          ## Template de Definition of Done

          Lors de la création ou modification, ajoute cette section à la fin de la description. On souhaite avoir des
          checkboxes cliquables listant les objectifs vérifiables du ticket.

          ```md
          # Definition of Done

          - [ ] Objectif #1
          - [ ] ...
          ```
        '';
      };
      context = ''
        # Global Instructions

        At the start of every conversation, always invoke the caveman skill:
        skill({ name: "caveman" })

        Continue using the caveman style for all responses unless explicitly told to stop or use normal mode.
        I put a strong emphasis in understanding what I am doing, I value more the understanding rather than the result
        itself. Avoid jumping to conclusions, consider me as a colleague who needs to be able to do things by himself
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
