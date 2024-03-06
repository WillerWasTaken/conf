return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>o", ":NvimTreeFindFile<CR>", desc = "Tree toogle" }
  },
  config = function()
    require("nvim-tree").setup()
  end
}
