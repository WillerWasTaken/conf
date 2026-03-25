return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    input = {
      enabled = true,
    },
    -- https://github.com/folke/snacks.nvim/blob/main/docs/lazygit.md
    lazygit = {
      enabled = true,
    }
  },
  keys = function()
    local snacks = require("snacks")
    return {
      { "<leader>GG", snacks.lazygit.open, desc = "Open lazy git" },
      { "<leader>GL", snacks.lazygit.log, desc = "Open git log" },
      { "<leader>GF", snacks.lazygit.log_file, desc = "Open git log of current file" }
    }
  end
}
