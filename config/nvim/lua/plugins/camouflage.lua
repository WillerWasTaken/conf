return {
  "zeybek/camouflage.nvim",
  event = "VeryLazy",
  opts = {
    pwned = {
      enabled = false,
    },
  },
  keys = function()
    local camouflage = require("camouflage")
    return {
      { "<leader>ct", camouflage.toggle,               desc = "Toggle Camouflage" },
      { "<leader>cl", camouflage.toggle_follow_cursor, desc = "Toggle Camouflage follow cursor" },
    }
  end
}
