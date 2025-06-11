return {
  'saghen/blink.cmp',
  dependencies = {
    -- snippets
    'rafamadriz/friendly-snippets',
    {"L3MON4D3/LuaSnip"},
  },
  -- use a release tag to download pre-built binaries
  version = '1.*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    completion = {
      documentation = {
        auto_show = true
      },
    },
  },
}
