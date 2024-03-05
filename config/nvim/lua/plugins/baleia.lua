return {
  "m00qek/baleia.nvim",
  config = function()
    local baleia = require('baleia').setup()
    vim.api.nvim_create_user_command('BaleiaColorize', function()
      baleia.once(vim.fn.bufnr('%'))
    end, {})
  end
}
