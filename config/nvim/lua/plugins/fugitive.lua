return {
  "tpope/vim-fugitive",
  dependencies = { "airblade/vim-gitgutter" },
  keys = {
    { "<leader>g", "<cmd>G<CR>", desc = "Toggle fugitive" }
  },
  lazy = false
}
