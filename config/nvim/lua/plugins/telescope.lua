return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sharkdp/fd",
    "nvim-tree/nvim-web-devicons",
    -- Extensions
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end
    },
    {
      "nvim-telescope/telescope-ui-select.nvim",
      config = function()
        -- sets telescope as global picker `vim.ui.select`
        require("telescope").load_extension("ui-select")
      end
    }
  },
  keys = function()
    local builtin = require("telescope.builtin")
    return {
      { "<leader>f", builtin.find_files },
      { "<leader>F", function() builtin.find_files({hidden=true}) end },
      { "<leader>s", builtin.live_grep },
      { "<leader>b", builtin.buffers },
    }
  end,
  opts = function()
    local actions = require("telescope.actions")
    return {
      defaults = {
        mappings = {
          i = {
            ["<Tab>"]   = actions.toggle_selection + actions.move_selection_better,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<C-q>"]   = actions.send_selected_to_qflist + actions.open_qflist,
            ["<M-q>"]   = actions.send_to_qflist + actions.open_qflist,
          },
          n = {
            ["<Tab>"]   = actions.toggle_selection + actions.move_selection_better,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<C-q>"]   = actions.send_selected_to_qflist + actions.open_qflist,
            ["<M-q>"]   = actions.send_to_qflist + actions.open_qflist,
            ["q"]       = actions.close,
          }
        }
      },
      pickers = {
        colorscheme = {
          enable_preview = true
        }
      }
    }
  end
}
