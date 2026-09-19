{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # LSP
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

      # Treesitter
      tree-sitter
    ];

    file = with config.lib.helpers; {
      ".config/nvim".source = configSymlink "nvim";
    };
  };

  programs = {
    neovim = {
      enable = true;
      # Do not handle init.lua file here
      sideloadInitLua = true;
      defaultEditor = true;
      package = pkgs.unstable.neovim-unwrapped;
    };
  };
}
