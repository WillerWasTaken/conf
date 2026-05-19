return {
  "declancm/maximize.nvim",
  keys = function()
    local maximize = require("maximize")
    return {
      { "<leader>z", maximize.toggle, desc = "Toggle buffer zoom" },
    }
  end,
}
