return {
  "hashivim/vim-terraform",
  config = function()
    vim.g.terraform_align = 1
    vim.g.terraform_fmt_on_save = 1

    -- Fix autoformat when using terragrunt within asdf
    vim.g.terraform_binary_path = "/home/willer/.asdf/shims/terraform"
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.hcl",
      command = "call terraform#fmt()"
    })
  end
}
