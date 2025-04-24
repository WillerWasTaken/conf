return {
  "tpope/vim-fugitive",
  dependencies = { "airblade/vim-gitgutter" },
  keys = {
    { "<leader>g", function() vim.cmd("G") end, desc = "Toggle fugitive", mode = {"n"}}
  },
  lazy = false
}
