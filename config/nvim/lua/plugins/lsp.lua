return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.enable({
      "rust_analyzer",
      "bashls",
      "docker_compose_language_service",
      "dockerls",
      "gopls",
      "harper_ls",
      "jqls",
      "jsonls",
      "lua_ls",
      "nginx_language_server",
      "pylsp",
      "terraformls",
    })

    vim.lsp.config('harper_ls', {
    settings = {
      ["harper-ls"] = {
        linters = {
          SentenceCapitalization = false
        }
      }
    }
    })

    vim.api.nvim_create_autocmd({"BufWritePre"}, {
      pattern = {"*.tf", "*.tfvars", "*.hcl"},
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end
}
