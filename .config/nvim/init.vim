source $VIMRUNTIME/mswin.vim

call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'cloudhead/neovim-fuzzy'
Plug 'editorconfig/editorconfig-vim'
Plug 'phanviet/vim-monokai-pro'
Plug 'sheerun/vim-polyglot'
Plug 'tomtom/tcomment_vim'
Plug 'vimlab/split-term.vim'
Plug 'Yggdroot/indentLine'

call plug#end()

set termguicolors
colorscheme monokai_pro

set colorcolumn=120
set expandtab
set hidden
set ignorecase
set mouse=a
set number
set scrolloff=5
set shiftround
set shiftwidth=4
set smartcase
set splitbelow
set splitright
set tabstop=4
set wildmode=longest,list,full

let mapleader = " "

nnoremap <silent> <leader>ve :e $MYVIMRC<CR>
nnoremap <silent> <leader>vr :source $MYVIMRC<CR>
nnoremap <silent> <leader><CR> :nohl<CR>

nnoremap <silent> <leader>, :bp<CR>
nnoremap <silent> <leader>. :bn<CR>
nnoremap <silent> <TAB> :b#<CR>

vnoremap < <gv
vnoremap > >gv

vnoremap <silent> <leader>y "+y<CR>
vnoremap <silent> <leader>p "+p<CR>

noremap <silent> <C-\> :vsp<CR>

nnoremap <silent> <leader>' :Term<CR>

nnoremap <silent> <C-p> :FuzzyOpen<CR>
nnoremap <silent> <C-f> :FuzzyGrep<CR>
