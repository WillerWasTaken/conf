return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sharkdp/fd",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
  },
  keys = {
      { "<leader>f", function() require("telescope.builtin").find_files() end },
      { "<leader>F", function() require("telescope.builtin").find_files({hidden=true}) end },
      { "<leader>s", function() require("telescope.builtin").live_grep() end }
  },
  config = function()
    -- Extensions
    require("telescope").load_extension("fzf")
  end
}
