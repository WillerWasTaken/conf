return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "lewis6991/gitsigns.nvim",
      keys = function()
        local gitsigns = require("gitsigns")
        return {
          { "<leader>hp", gitsigns.preview_hunk_inline,             desc = "Preview hunk" },
          { "<leader>hu", gitsigns.reset_hunk,                      desc = "Undo hunk" },
          { "<leader>hs", gitsigns.stage_hunk,                      desc = "Stage hunk" },
          { "<leader>gb", gitsigns.blame,                           desc = "Toggle blame" },
          { "<leader>hd", gitsigns.diffthis,                        desc = "Diff this" },
          { "]c",         function() gitsigns.nav_hunk("next") end, desc = "Preview hunk" },
          { "[c",         function() gitsigns.nav_hunk("prev") end, desc = "Preview hunk" },
        }
      end
    },
    -- diff tool
    "esmuellert/codediff.nvim",
    -- picker
    "nvim-telescope/telescope.nvim",
  },
  cmd = "Neogit",
  opts = {
    prompt_amend_commit = false,
    mappings = {
      status = {
        -- Fugitive style toggle
        ["="] = "Toggle",
      }
    }
  },
  keys = function()
    local neogit = require("neogit")
    return {
      { "<leader>gg", neogit.open,                        desc = "Show Neogit UI" },
      { "<leader>gd", function() vim.cmd("CodeDiff") end, desc = "Toggle codediff" }
    }
  end
}
