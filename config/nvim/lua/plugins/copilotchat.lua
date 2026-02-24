return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  build = "make tiktoken",
  opts = {
    -- Default model is "gpt-4.1"; override with best Claude via Copilot
    model = "claude-sonnet-4.6",
  },
  keys = function()
    local copilot = require("CopilotChat")
    return {
      { "<leader>aa", mode = {"n", "x"}, copilot.toggle, desc = "Open CopilotChat" },
    }
  end,
}
