return {
  "tpope/vim-commentary",
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "cue",
      callback = function()
        vim.opt_local.commentstring = "// %s"
      end,
    })
  end,
}
