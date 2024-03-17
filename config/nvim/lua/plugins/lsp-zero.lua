return {
  "VonHeikemen/lsp-zero.nvim",
  branch="v3.x",
  dependencies = {
    -- LSP management
    {"neovim/nvim-lspconfig"},

    -- Autocomplete
    {"hrsh7th/cmp-nvim-lsp"},
    {"hrsh7th/nvim-cmp"},
    {"L3MON4D3/LuaSnip"},
  },
  config = function()
    local lsp_zero = require("lsp-zero")

    lsp_zero.setup({
    })
    lsp_zero.on_attach(function(client, bufnr)
      -- see :help lsp-zero-keybindings
      -- to learn the available actions
      lsp_zero.default_keymaps({buffer = bufnr})
      vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end, { buffer = bufnr })
      vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, { buffer = bufnr })
    end)

    -- Setup language servers.
    local lspconfig = require('lspconfig')
    lspconfig.lua_ls.setup({
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' }
                }
            }
        }
    })
    lspconfig.gopls.setup({})
    lspconfig.ansiblels.setup({})
    lspconfig.bashls.setup({})
    lspconfig.terraform_lsp.setup({})
  end
}
