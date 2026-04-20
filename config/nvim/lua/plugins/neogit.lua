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
    commit_editor = {
      kind = "floating",
    },
    commit_select_view = {
      kind = "floating",
    },
    commit_view = {
      kind = "floating",
    },
    log_view = {
      kind = "floating",
    },
    rebase_editor = {
      kind = "floating",
    },
    reflog_view = {
      kind = "floating",
    },
    merge_editor = {
      kind = "floating",
    },
    preview_buffer = {
      kind = "floating",
    },
    popup = {
      kind = "floating",
    },
    stash = {
      kind = "floating",
    },
    refs_view = {
      kind = "floating",
    },
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
      { "<leader>gg", function() neogit.open({ kind = "floating" }) end, desc = "Show Neogit UI" },
      { "<leader>gd", function() vim.cmd("CodeDiff") end,                desc = "Toggle codediff" }
    }
  end
}
