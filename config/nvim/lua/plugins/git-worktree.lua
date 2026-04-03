return {
  "ThePrimeagen/git-worktree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  keys = function()
    local telescope_git_worktree = require("telescope").extensions.git_worktree
    local git_worktree = require("git-worktree")
    return {
      { "<leader>gw", telescope_git_worktree.git_worktree, desc = "Open git worktree" },
      { "<leader>gW",
        function()
          local branches = vim.fn.systemlist("git branch -r --format='%(refname:short)'")
          local remote = "origin"

          local choices = {}
          for _, branch in ipairs(branches) do
            if branch ~= remote then
              local name = branch:gsub("^" .. remote .. "/", "")
              table.insert(choices, name)
            end
          end
          table.insert(choices, "[Custom]")

          vim.ui.select(choices, { prompt = "Select branch or [Custom] to enter name: " }, function(choice)
            if not choice then return end

            if choice == "[Custom]" then
              vim.ui.input({ prompt = "Enter branch name: " }, function(input)
                  if input and input ~= "" then
                    git_worktree.create_worktree(input, input, "origin")
                  end
                end)
            else
              git_worktree.create_worktree(choice, choice, "origin")
            end
          end)
        end, desc = "Create a new git worktree" },
    }
  end,
  config = function()
    require("telescope").load_extension("git_worktree")

    local git_worktree = require("git-worktree")
    git_worktree.on_tree_change(function(op, metadata)
      if op == git_worktree.Operations.Delete then
        local get_git_root = function()
          return vim.fn.trim(vim.fn.system("git rev-parse --git-common-dir"))
        end

        -- deduce the branch name using relative path of the worktree
        local branch = metadata.path:sub(#get_git_root() + 2)
        vim.notify("Deleting branch " .. branch, vim.log.levels.INFO)

        local delete_branch = vim.fn.system("git branch --delete " .. branch)

        if vim.v.shell_error ~= 0 then
          vim.notify("Failed to delete branch: " .. delete_branch, vim.log.levels.ERROR)
          return
        end
        vim.notify("Branch deleted " .. branch, vim.log.levels.INFO)

        local fetch_prune = vim.fn.system("git fetch --prune")
        if vim.v.shell_error ~= 0 then
          vim.notify("Failed to fetch: " .. fetch_prune, vim.log.levels.ERROR)
          return
        end
        vim.notify(fetch_prune, vim.log.levels.INFO)
      end
    end)
  end,
}
