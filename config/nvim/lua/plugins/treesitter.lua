return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ':TSUpdate',
  branch = 'main',
  config = function()
    local parsers = {
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
    }
    require('nvim-treesitter').install(parsers)
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local buf, filetype = args.buf, args.match

        local language = vim.treesitter.language.get_lang(filetype)
        if not language then return end

        -- if parser exists, load it
        if not vim.treesitter.language.add(language) then return end
        -- enable syntax highlighting, folds

        vim.treesitter.start(buf, language)
        -- ...and indentation
        -- vim.bo.indentexpr = "v:lua-require'nvim-treesitter'.indentexpr()"
      end
    })
  end,
  opts = {
    auto_install = false,
  },
}
