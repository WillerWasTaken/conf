" smart search
set ignorecase
set smartcase

" move up and down 'visually' line by line
nnoremap j gj
nnoremap k gk

" jk to escape in insert
inoremap jk <Esc>

" more natural split order
set splitbelow
set splitright

" leader key
let mapleader = " "

" hide search higlight
nnoremap <leader>a :nohlsearch<CR>

" split movement
nnoremap <leader>h <C-W>h
nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l

" save shortcut
nnoremap <leader>w :w<CR>

" quit shortcut
nnoremap <leader>q :q<CR>

" Set linenumbers
set number
" Get relative numbers
set relativenumber
" Highlight the current line
set cursorline
