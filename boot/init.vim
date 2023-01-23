call plug#begin()
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'Mofiqul/dracula.nvim'
call plug#end()

colorscheme dracula

" general text editing
set ts=4 sts=4 sw=4 et si

" ui
set cc=80 so=8 scl=yes rnu nu nohlsearch nowrap

" behaviour
set hidden
set updatetime=50
set noswapfile
set nobackup
set undodir=~/.vim/undo
set undofile
set path+=**

" civilized menu
set wildmode=longest,list,full
set wildmenu
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*

let mapleader = " "

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" autocmd

