return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>o", ":NvimTreeFindFile<CR>", desc = "Tree toogle" }
  },
  lazy = false,
  config = function()
    -- Completely disable builtin netrw in favor of nvim tree
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      on_attach = function(bufnr)
        local api = require('nvim-tree.api')

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set('n', 'CD', api.tree.change_root_to_node, opts('CD'))
      end,
      actions = {
        open_file = {
          window_picker = {
            -- Remove picker for open and split
            enable = false,
          },
        },
      }
    })
  end
}
