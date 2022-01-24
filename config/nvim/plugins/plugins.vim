" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " File Explorer
    Plug 'scrooloose/NERDTree'
    " One Dark theme
    Plug 'joshdick/onedark.vim'
    " Pane/split navigation between vim and tmux (cf ~/.tmux.conf)
    " https://robots.thoughtbot.com/seamlessly-navigate-vim-and-tmux-splits
    Plug 'christoomey/vim-tmux-navigator'
    " gcc to comment
    Plug 'tpope/vim-commentary'
    " Status bar
    Plug 'vim-airline/vim-airline'
    " Starting screen
    Plug 'mhinz/vim-startify'
    " Git
    Plug 'tpope/vim-fugitive'
    " Git side markers
    Plug 'airblade/vim-gitgutter'
    " Telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    " Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " Lsp
    Plug 'neovim/nvim-lspconfig'
    " Autocomplete
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'L3MON4D3/LuaSnip'
    " Sneak
    Plug 'justinmk/vim-sneak'
    " Ranger
    Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
call plug#end()

" ########## THEME ##########
source $HOME/.config/nvim/themes/onedark.vim

" ########## STARTIFY ##########
let g:startify_custom_header = [
        \'                __                    __           ___',
        \'               /\ \__                /\ \__  __  /''___\',
        \'           ____\ \ ,_\    __     _ __\ \ ,_\/\_\/\ \__/  __  __',
        \'          /'',__\\ \ \/  /''__`\  /\`''__\ \ \/\/\ \ \ ,__\/\ \/\ \',
        \'         /\__, `\\ \ \_/\ \L\.\_\ \ \/ \ \ \_\ \ \ \ \_/\ \ \_\ \',
        \'         \/\____/ \ \__\ \__/.\_\\ \_\  \ \__\\ \_\ \_\  \/`____ \',
        \'          \/___/   \/__/\/__/\/_/ \/_/   \/__/ \/_/\/_/   `/___/> \',
        \'                                                             /\___/',
        \'                                                             \/__/',
        \]

" Menu order
let g:startify_lists = [
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

" Session folder
let g:startify_session_dir = '~/.config/nvim/session'

" Handful bookmarks
let g:startify_bookmarks = [
            \ { 'v': '~/.config/nvim/init.vim' },
            \ { 'z': '~/conf/dotfiles/zshrc' },
            \ { 'i': '~/conf/i3/config' },
            \ { 't': '~/conf/dotfiles/tmux.conf' },
            \ { 'i': '~/.config/i3/config' },
            \ '~/proj',
            \ ]

" Find project root
let g:startify_change_to_vcs_root = 1

" Automatically update session
let g:startify_session_persistence = 1

" ########## AIRLINE ##########
" Powerline fonts theme
let g:airline_powerline_fonts = 1
" Fancy tab
let g:airline#extensions#tabline#enabled = 1
" Just display tabs, disregard buffers
let g:airline#extensions#tabline#show_buffers = 0

" ########## RANGER ##########
" Make Ranger replace netrw and be the file explorer
let g:rnvimr_ex_enable = 1

" ### LSP + AUTO COMPLETE ###
lua << EOF
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'bashls', 'pyright', 'dockerls', 'java_language_server', 'terraformls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
EOF
