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
      { "s", mode = { "n", "x", "o" }, function() flash.jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() flash.treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() flash.remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() flash.treesitter_search() end, desc = "Treesitter Search" },
    }
  end
}
