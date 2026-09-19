{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      zplug
    ];

    file = with config.lib.helpers; {
      ".p10k.zsh".source = dotfileSymlink "p10k.zsh";
      ".zshrc.manual".source = dotfileSymlink "zshrc";
    };
  };

  programs = {
    zsh = {
      enable = true;
      sessionVariables = {
        ZPLUG_DIR = "${pkgs.zplug}/share/zplug";
        FZF_DIR = "${pkgs.fzf}/share/fzf";
        ASDF_DIR = "${pkgs.asdf-vm}/share/asdf-vm";
      };
      initContent = pkgs.lib.mkOrder 1500 ''
        source ~/.zshrc.manual
      '';
    };
  };
}
