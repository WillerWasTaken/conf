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
    local get_git_root = function()
      return vim.fn.trim(vim.fn.system("git rev-parse --git-common-dir"))
    end
    return {
      { "<leader>f", builtin.find_files, desc = "Find files in the current directory" },
      { "<leader>gf", function()
          return builtin.find_files({cwd=get_git_root()})
        end, desc = "Find files from the git root"},
      { "<leader>F", function() builtin.find_files({hidden=true}) end, desc = "Find files including hidden files" },
      { "<leader>gF", function()
          return builtin.find_files({cwd=get_git_root(), hidden=true})
        end, desc = "Find files including hidden files from the git root"},
      { "<leader>S", builtin.live_grep, desc = "Live grep in the current directory" },
      { "<leader>gS", function()
          return builtin.live_grep({cwd=get_git_root()})
        end, desc = "Live grep from the git root" },
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
