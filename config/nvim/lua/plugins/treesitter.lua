return {
  'nvim-treesitter/nvim-treesitter',
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
  },
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "comment",
      "css",
      "csv",
      "diff",
      "dockerfile",
      "git_config",
      "git_rebase",
      "gitcommit",
      "gitignore",
      "go",
      "gomod",
      "hcl",
      "helm",
      "html",
      "java",
      "javascript",
      "jq",
      "json",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "nginx",
      "nix",
      "pem",
      "python",
      "query",
      "regex",
      "requirements",
      "rust",
      "sql",
      "ssh_config",
      "strace",
      "terraform",
      "typescript",
      "vimdoc",
      "xml",
      "yaml"
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
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end
}
