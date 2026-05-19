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

    -- Wrap save_session to handle worktree, to cwd back to bare directory first then restore
    local original_save = auto_session.save_session
    auto_session.save_session = function(...)
      local cwd = vim.fn.getcwd()
      local bare_root = nil

      local git_common = vim.fn.trim(vim.fn.system("git rev-parse --git-common-dir"))
      if vim.v.shell_error == 0 and git_common ~= "." then
        local is_bare = vim.fn.trim(vim.fn.system(
          "git -C " .. vim.fn.shellescape(git_common) .. " rev-parse --is-bare-repository"
        ))
        if is_bare == "true" then
          bare_root = git_common
          vim.g._autosession_worktree = cwd
          vim.cmd("noautocmd cd " .. vim.fn.fnameescape(bare_root))
        end
      end

      local result = original_save(...)

      if bare_root then
        vim.cmd("noautocmd cd " .. vim.fn.fnameescape(cwd))
        vim.g._autosession_worktree = nil
      end
      return result
    end
  end,
  enabled = vim.env.KITTY_SCROLLBACK_NVIM ~= "true"
}
