return {
  "szw/vim-maximizer",
  keys = {
    { "<leader>z", function() vim.cmd("MaximizerToggle") end, desc = "Toggle buffer zoom" }
  }
}
