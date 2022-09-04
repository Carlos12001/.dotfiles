"Auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

"Nvim config
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
set ignorecase              " case insensitive 
set ignorecase              " case insensitive 
set number                  " set number
set relativenumber          " relative line numbers
set foldmethod=syntax       " the folds will be specified from the syntax definitions
set foldlevel=99            " not init collapse
nnoremap o o<Esc>k          " not exit normal mode and stay here
nnoremap O O<Esc>j          " not exit normal mode and stay here
set encoding=UTF-8          " set the enconding for icons

"Plugins
call plug#begin('~/AppData/Local/nvim/plugged') 

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " File Explorer
    Plug 'scrooloose/NERDTree'
    "One Dark Theme
    Plug 'joshdick/onedark.vim'
    "Vim-Airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    "Dracula Theme
    Plug 'dracula/vim', { 'as': 'dracula' }
    "Icons in NerdTree
    Plug 'ryanoasis/vim-devicons' 

call plug#end()


"Configs Plugs
colorscheme dracula         " set theme dracula
let g:airline_theme ='dracula' " set airline onedarkMy Pluging:echo stdpath('config')s
