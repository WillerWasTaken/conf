return {
  "ggandor/leap.nvim",
  config = function()
    require("leap").create_default_mappings()

    -- Invert the default on scrollback as the cursor will be at the bottom
    if vim.env.KITTY_SCROLLBACK_NVIM == 'true' then
        vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-forward)')
        vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-backward)')
    end
  end
}
