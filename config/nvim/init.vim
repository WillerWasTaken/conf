source $HOME/.config/nvim/plugins/plugins.vim

" ########## GENERAL ##########
" Smart search
set ignorecase
set smartcase
set incsearch
set hlsearch

" Show command as it is being typed
set showcmd

" Numbers on the side
set number
set relativenumber

" Highlight the current line
set cursorline

" Move up and down 'visually' line by line
nnoremap j gj
nnoremap k gk

" jk to escape in insert
inoremap jk <Esc>

" Open in a new tab with gF
nnoremap gF <C-W>gf
vnoremap gF <C-W>gf

" More natural split order
set splitbelow
set splitright

" Default indentation when no filetype is detected
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab

" Display column for the 120th character
set colorcolumn=120

" Show trailing whitespaces as dashes
set list
set listchars=tab:▸\ ,trail:·,extends:>,precedes:<,nbsp:+

" ########## GENERAL SHORTCUTS ##########
" Leader on space
let mapleader = " "

" Vim configuration manipulation
nnoremap <leader>ce :tabnew<CR>:lcd ~/conf<CR>:e ~/conf/dotfiles/vimrc<CR>
nnoremap <leader>cs :source ~/.config/nvim/init.vim<CR>

" Edits
nnoremap <leader>es :set spell!<CR>
nnoremap <leader>er :set rnu!<CR>

" Open buffer
nnoremap <leader>b :buffer 

" Diff
nnoremap <leader>dt :windo diffthis<CR>
nnoremap <leader>do :windo diffoff<CR>

" Deactivate search highlight
nnoremap <leader>a :nohlsearch<CR>

" Search under visual
vnoremap / y/\V<C-r>=escape(@",'/\')<CR><CR>
vnoremap ? y?\V<C-r>=escape(@",'/\')<CR><CR>

" Move between split
nnoremap <leader>h <C-W>h
nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l

" Save
nnoremap <leader>w :w<CR>

" Quit
nnoremap <leader>q :q<CR>

" ########## PLUGINS CONFIGURATION ##########
" ### NERDTREE ###
" Activate Nerdtree
nnoremap <leader>o :NERDTreeFind<cr>
" New tab with nerdtree
nnoremap <leader>n :tabnew<CR>:NERDTree<CR>

" ### Telescope ###
" Find file
nnoremap <leader>f :Telescope find_files<cr>
" Grep 
nnoremap <leader>s :Telescope live_grep<cr>
nnoremap <leader>S :Telescope live_grep search_dirs=

" ### GIT (FUGITIVE) ###
nnoremap <leader>g :G<CR>

" ### RANGER ###
nmap <space>r :RnvimrToggle<CR>

" ########## LANGUAGE ##########
