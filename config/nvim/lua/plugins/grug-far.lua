return {
  "MagicDuck/grug-far.nvim",
  -- Available options
  -- https://github.com/MagicDuck/grug-far.nvim/blob/main/lua/grug-far/opts.lua
  opts = {
    keymaps = {
      close = { n = "q" },
      qflist = { n = "<C-q>" },
      openNextLocation = { n = "<C-n>" },
      openPrevLocation = { n = '<C-p>' },
    },
  },
  keys = function()
    local grug_far = require("grug-far")
    return {
      { "<leader>s", mode = { "n", "x" }, grug_far.open, desc = "Toggle GrugFar" },
    }
  end,
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "grug-far",
      callback = function(ev)
        -- Defer the call to wait grugfar to first set the buggy mappings
        vim.schedule(function()
          -- restore normal p/P behavior so register-prefixed paste works (e.g. "+p)
          vim.api.nvim_buf_del_keymap(ev.buf, "n", "p")
          vim.api.nvim_buf_del_keymap(ev.buf, "v", "p")
          vim.api.nvim_buf_del_keymap(ev.buf, "n", "P")
          vim.api.nvim_buf_del_keymap(ev.buf, "v", "P")
        end)
      end,
    })
  end
}
