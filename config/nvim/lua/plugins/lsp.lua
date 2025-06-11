return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.enable({
      "rust_analyzer",
      "ansiblels",
      "bashls",
      "docker_compose_language_service",
      "dockerls",
      "gopls",
      "jqls",
      "jsonls",
      "lua_ls",
      "nginx_language_server",
      "pylsp",
      "terraformls",
    })
  end
}
