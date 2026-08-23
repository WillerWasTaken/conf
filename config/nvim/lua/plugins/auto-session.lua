local git = require("lib.git")

return {
  "rmagatti/auto-session",
  lazy = false,
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { "~/", "~/Downloads", "/" },
    -- Delete after 10 days of inactivity
    purge_after_minutes = 14400,

    save_extra_cmds = {
      function()
        if vim.g._autosession_worktree then
          return { "cd " .. vim.fn.fnameescape(vim.g._autosession_worktree) }
        end
      end,
    },
  },
  config = function(_, opts)
    local auto_session = require("auto-session")
    auto_session.setup(opts)

    -- Wrap save_session to handle worktree, to cwd back to top-level directory first then restore
    local original_save = auto_session.save_session
    auto_session.save_session = function(...)
      local cwd = vim.fn.getcwd()
      local git_top_level_directory = git.get_top_level_directory()

      if git_top_level_directory then
        vim.g._autosession_worktree = cwd
        vim.cmd("noautocmd cd " .. vim.fn.fnameescape(git_top_level_directory))
      end

      local result = original_save(...)

      if git_top_level_directory then
        vim.cmd("noautocmd cd " .. vim.fn.fnameescape(cwd))
        vim.g._autosession_worktree = nil
      end
      return result
    end
  end,
  enabled = vim.env.KITTY_SCROLLBACK_NVIM ~= "true"
}
