return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    sections = {
      lualine_x = {
        -- Display statusline with "%S"
        -- https://github.com/folke/noice.nvim/issues/579#issuecomment-1821715523
        {
          "%S",
          color = { fg = "#ff9e64" }
        },
        -- Showing when recording macros
        -- https://github.com/nvim-lualine/lualine.nvim/issues/1355
        {
          function()
            local reg = vim.fn.reg_recording()
            if reg ~= "" then
              return "Recording @" .. reg
            else
              return nil
            end
          end,
          cond = function() return vim.fn.reg_recording() ~= "" end,
          color = { fg = "#ff9e64" }
        },
        -- Default components for x section
        "encoding", "fileformat", "filetype" },
    },
  },
  init = function ()
    -- Use lualine to show commands
    vim.opt.showcmdloc = "statusline"
  end
}
