return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    jump = {
      -- automatically jump when there is only one match
      autojump = true,
    },
    modes = {
      char = {
        -- disable f, t enhancement
        enabled = false,
      },
    }
  },
  -- stylua: ignore
  keys = function()
    local flash = require("flash")
    return {
      { "s", mode = { "n", "x", "o" }, flash.jump, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, flash.treesitter, desc = "Flash Treesitter" },
      { "r", mode = "o", flash.remote, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, flash.treesitter_search, desc = "Treesitter Search" },
    }
  end
}
