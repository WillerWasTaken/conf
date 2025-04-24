return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sharkdp/fd",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
  },
  keys = function()
    local builtin = require("telescope.builtin")
    return {
      { "<leader>f", function() builtin.find_files() end },
      { "<leader>F", function() builtin.find_files({hidden=true}) end },
      { "<leader>s", function() builtin.live_grep() end }
    }
  end,
  config = function()
    -- Extensions
    local telescope = require("telescope")
    telescope.load_extension("fzf")

    local actions = require("telescope.actions")
    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<Tab>"]   = actions.toggle_selection + actions.move_selection_better,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<C-q>"]   = actions.send_selected_to_qflist + actions.open_qflist,
            ["<M-q>"]   = actions.send_to_qflist + actions.open_qflist,
          },
          n= {
            ["<Tab>"]   = actions.toggle_selection + actions.move_selection_better,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<C-q>"]   = actions.send_selected_to_qflist + actions.open_qflist,
            ["<M-q>"]   = actions.send_to_qflist + actions.open_qflist,
          }
        }
      },
      pickers = {
        colorscheme = {
          enable_preview = true
        }
      }
    })
  end
}
