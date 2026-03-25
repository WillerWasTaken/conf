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
  end,
}
