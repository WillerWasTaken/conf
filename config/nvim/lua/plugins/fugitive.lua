return {
  "tpope/vim-fugitive",
  dependencies = {
    {
      "airblade/vim-gitgutter",
      init = function ()
        -- Update signs as soon as save is performed to avoid the delay
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
          pattern = {"*"},
          callback = function() vim.cmd("GitGutter") end,
        })
      end
    },
  },
  keys = {
    { "<leader>g", function() vim.cmd("G") end, desc = "Toggle fugitive", mode = {"n"}}
  },
  lazy = false
}
