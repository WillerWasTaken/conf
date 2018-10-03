" In order to use vim diff in git diff:
" In ~/.gitconfig:
" [diff]
"   external = ~/tools/git_diff_wrapper
" [pager]
"   diff =
" In ~/tools/git_diff_wrapper (with executable mode):
" #! /bin/sh
" nvim -d "$2" "$5"
" OR
" vimdiff "$2" "$5"

" Install vam
" git clone https://github.com/MarcWeber/vim-addon-manager ~/.vim/vad

" vam configuration
set rtp+=~/.vim/vad

" addons
let addons = []
" gcc to comment
let addons += ['github:tpope/vim-commentary']
" swag status bar
let addons += ['github:bling/vim-airline']
" syntax correction (works !? conflict with fugitive ?)
let addons += ['github:scrooloose/syntastic']
" colorscheme
let addons += ['github:nanotech/jellybeans.vim']
" Control+P to find file
let addons += ['github:ctrlpvim/ctrlp.vim']
" Gwrite/Gread/Gdiff...
let addons += ['github:tpope/vim-fugitive']
" git side helper
let addons += ['github:mhinz/vim-signify']
" File tree helper
let addons += ['github:scrooloose/nerdtree']

" auto update the addons
call vam#ActivateAddons(addons, {'auto_install' : 1})

" set the addon colorscheme
colorscheme jellybeans

" fold method
setlocal foldmethod=indent

" Default indentation when no filetype is detected
setlocal tabstop=8
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab

" Show trailing whitespaces as dashes
set list
set listchars=tab:▸\ ,trail:·,extends:>,precedes:<,nbsp:+

source ~/.config/nvim/common.vim

" activate nerdtree
nnoremap <leader>o :NERDTree<CR>

