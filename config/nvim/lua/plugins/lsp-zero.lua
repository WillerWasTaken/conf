-- Disable lsp when using scrollback
if vim.env.KITTY_SCROLLBACK_NVIM == 'true' then
    return {}
end

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
      vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = bufnr })
      vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { buffer = bufnr })
    end)

    -- Setup language servers.
    local lspconfig = require('lspconfig')
    lspconfig.ansiblels.setup({})
    lspconfig.bashls.setup({})
    lspconfig.docker_compose_language_service.setup({})
    lspconfig.dockerls.setup({})
    lspconfig.gopls.setup({})
    lspconfig.jqls.setup({})
    lspconfig.jsonls.setup({})
    -- Specific lua config for nvim
    lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())
    lspconfig.nginx_language_server.setup({})
    lspconfig.pylsp.setup({})
    lspconfig.rust_analyzer.setup({})
    lspconfig.terraformls.setup({})

    local cmp = require('cmp')
    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        -- Enter key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({select = false}),
      })
    })
  end
}
