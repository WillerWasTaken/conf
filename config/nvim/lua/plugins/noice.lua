return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    routes = {
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
