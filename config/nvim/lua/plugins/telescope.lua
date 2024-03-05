return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sharkdp/fd",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
  },
  config = function()
    -- Keymaps
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>f", builtin.find_files)
    vim.keymap.set("n", "<leader>F", function() builtin.find_files({hidden=true}) end)
    vim.keymap.set("n", "<leader>s", builtin.live_grep)

    -- Extensions
    require("telescope").load_extension("fzf")
  end
}
