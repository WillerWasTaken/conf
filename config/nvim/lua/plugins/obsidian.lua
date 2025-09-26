return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  ft = "markdown",
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    -- Disable default Zettelkasten id format
    note_id_func = function(title) return title end,
    callbacks = {
      post_set_workspace = function(workspace)
        -- Ensure the current working directory is the one of the workspace
        vim.api.nvim_set_current_dir(workspace.path.filename)
      end,
    },
    workspaces = {
      {
        name = "Second Brain",
        path = "~/vaults/Second Brain",
      },
    },
    completion = {
      blink = true,
      nvim_cmp = false,
    },
  },
  config = function(_, opts)
    -- https://github.com/epwalsh/obsidian.nvim/issues/286
    vim.opt.conceallevel = 1
    require("obsidian").setup(opts)

    -- Set mapping only when Obsidian is active
    vim.keymap.set("n", "<leader>f", function() vim.cmd("Obsidian quick_switch") end,
      { desc = "Find obsidian note" })
    vim.keymap.set("n", "<leader>s", function() vim.cmd("Obsidian search") end,
      { desc = "Search a note" })
  end,
  cmd = "Obsidian",
}
