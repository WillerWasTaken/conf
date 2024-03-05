return {
  "tpope/vim-fugitive",
  dependencies = { "airblade/vim-gitgutter" },
  config = function()
   vim.keymap.set("n", "<leader>g", "<cmd>G<CR>")
  end
}
