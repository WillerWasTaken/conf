return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>O", function() vim.cmd("NvimTreeFindFile!") end, desc = "Tree toogle" }
  },
  opts = {
    on_attach = function(bufnr)
      local api = require('nvim-tree.api')

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      vim.keymap.set('n', 'x',  api.node.navigate.parent_close, opts('Close Directory'))
      vim.keymap.set('n', 'X',  api.tree.collapse_all,          opts('Collapse'))
      vim.keymap.set('n', 'CD', api.tree.change_root_to_node,   opts('CD'))
    end,
    actions = {
      open_file = {
        window_picker = {
          -- Remove picker for open and split
          enable = false,
        },
      },
    }
  }
}
