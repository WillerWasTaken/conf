return {
  'nvim-treesitter/nvim-treesitter',
  build = "<cmd>TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "lua",
        "go",
        "gomod",
        "hcl",
        "helm",
        "html",
        "json",
        "make",
        "markdown",
        "markdown_inline",
        "pem",
        "python",
        "terraform",
        "yaml",
        "vimdoc"
      },
    })
  end
}
