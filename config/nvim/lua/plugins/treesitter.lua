return {
  'nvim-treesitter/nvim-treesitter',
  build = "<cmd>TSUpdate",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },

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
      -- Consistent syntax highlighting
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
      },
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["as"] = "@assignment.outer",
            ["is"] = "@assignment.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
              ["<C-Down>"] = "@function.outer",
          },
          goto_previous_start = {
              ["<C-Up>"] = "@function.outer",
          },
        },
        swap = {
          enable = true,
          swap_previous = {
              ["<leader>pl"] = "@parameter.inner",
          },
          swap_next = {
              ["<leader>pr"] = "@parameter.inner",
          },
        },
      },
    })
  end
}
