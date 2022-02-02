"Nvim config
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
set ignorecase              " case insensitive 
set ignorecase              " case insensitive 
set number                  " set number
set relativenumber          " relative line numbers
nnoremap o o<Esc>k          " not exit normal mode and stay here
nnoremap O O<Esc>j          " not exit normal mode and stay here

"Plugins
call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " File Explorer
    Plug 'scrooloose/NERDTree'
    "One Dark Theme
    Plug 'joshdick/onedark.vim'
    "Vim-Airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

call plug#end()


"Configs Plugs
colorscheme onedark         " set theme onedark
let g:airline_theme='onedark' " set airline onedark
