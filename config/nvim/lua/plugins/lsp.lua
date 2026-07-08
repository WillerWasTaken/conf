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

    local lua_libraries = vim.api.nvim_get_runtime_file("", true)
    -- add support for hypr libaries such as hl object
    local hypr_stubs = vim.env.HYPR_STUBS
    if hypr_stubs then
      table.insert(lua_libraries, hypr_stubs)
    end

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          workspace = { library = lua_libraries },
        },
      },
    })

    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      pattern = { "*.tf", "*.tfvars", "*.hcl", "*.lua" },
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end
}
