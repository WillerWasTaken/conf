return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "airblade/vim-gitgutter",
      init = function ()
        -- Update signs as soon as save is performed to avoid the delay
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
          pattern = {"*"},
          callback = function() vim.cmd("GitGutter") end,
        })
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
        { "<leader>gg", function() neogit.open({ kind = "floating" }) end , desc = "Show Neogit UI" },
        { "<leader>gd", function() vim.cmd("CodeDiff") end, desc = "Toggle codediff" }
    }
  end
}
