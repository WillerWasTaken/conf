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
    local get_git_root = function()
      return vim.fn.trim(vim.fn.system("git rev-parse --git-common-dir"))
    end
    return {
      { "<leader>s", mode = { "n", "x" }, grug_far.open, desc = "Toggle GrugFar" },
      { "<leader>gs", mode = { "n", "x" },
        function()
          return grug_far.open({
            prefills = {
              paths = get_git_root()
            }
          })
        end, desc = "Toggle GrugFar from the git root" },
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
