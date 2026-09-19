{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      worktrunk
    ];

    file = with config.lib.helpers; {
      ".gitconfig".source = dotfileSymlink "gitconfig";

      ".config/worktrunk".source = configSymlink "worktrunk";
    };
  };

  programs = {
    delta = {
      enable = true;
      enableGitIntegration = true;
    };

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
  };
}
