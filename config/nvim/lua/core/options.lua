local options = {
  -- Line numbers
  number = true,
  -- More natural splits
  splitbelow = true,
  splitright = true,
  -- Better search
  ignorecase = true,
  smartcase = true,
  -- Show current line
  cursorline = true,
  -- keep 5 lines at least between the cursor and the end of the buffer
  scrolloff = 5,
  -- Default indentation
  tabstop = 4,
  softtabstop = 4,
  shiftwidth = 4,
  expandtab = true,
  -- Display column for the 120th character
  colorcolumn = '120',
  -- Show trailing whitespaces as dashes
  list = true,
  listchars = 'tab:▸ ,trail:·,extends:>,precedes:<,nbsp:+',
  termguicolors = true
}

for opt, val in pairs(options) do
  vim.opt[opt] = val
end
