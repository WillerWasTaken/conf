return {
  "MagicDuck/grug-far.nvim",
  -- Available options
  -- https://github.com/MagicDuck/grug-far.nvim/blob/main/lua/grug-far/opts.lua
  opts = {
    keymaps = {
      close = { n = "q" },
      qflist = { n = "<C-q>" },
    },
  },
  keys = function()
    local grug_far = require("grug-far")
    return {
      { "<leader>s", mode = { "n", "x" }, grug_far.open, desc = "Toggle GrugFar" },
    }
  end,
}
