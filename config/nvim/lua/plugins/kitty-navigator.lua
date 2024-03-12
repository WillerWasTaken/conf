return {
  "knubie/vim-kitty-navigator",
  lazy = false,
  config = function()
    vim.g.kitty_navigator_enable_stack_layout = 1
  end,
  keys = {
    {"<C-h>", function() vim.cmd("KittyNavigateLeft") end, desc = "Move left a Split", mode = {"n"}},
    {"<C-j>", function() vim.cmd("KittyNavigateDown") end, desc = "Move down a Split", mode = {"n"}},
    {"<C-k>", function() vim.cmd("KittyNavigateUp") end, desc = "Move up a Split", mode = {"n"}},
    {"<C-l>", function() vim.cmd("KittyNavigateRight") end, desc = "Move right a Split", mode = {"n"}}
  }
}
