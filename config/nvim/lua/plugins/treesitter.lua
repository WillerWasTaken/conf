return {
  'nvim-treesitter/nvim-treesitter',
  build = "<cmd>TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua"
      }
    })
end
}
