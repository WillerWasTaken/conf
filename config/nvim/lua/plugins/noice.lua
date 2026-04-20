return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    routes = {
      -- Default configuration ignores shell commands
      -- https://github.com/folke/noice.nvim/issues/1097#issuecomment-3623860528
      {
        filter = {
          event = "msg_show",
          kind = { 'shell_out', 'shell_err' },
        },
        view = "notify",
      },
      {
        -- Long messages as popup
        filter = {
          event = "msg_show",
          min_height = 50,
        },
        view = "popup",
      },
    },
    views = {
      popup = {
        size = {
          width = "90%",
          height = "90%",
        },
      },
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
}
