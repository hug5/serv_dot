" Save in user's home folder, ~/
" ---------------------------------------

" Line number
:set number
"
" Relative line number
" :set relativenumber
"
" ignore case in search
:set ic
"
" set highlight search
:set hls
" Can unset highlight with, :nohl
"
" incremental search
:set is



"https://www.fullstackpython.com/vim.html

" Enable syntax highlighting
" Can also do, syntax on
syntax enable
" Set tab spacing
set ts=2
" indent when moving to the next line
set autoindent
" Expand tabs into spaces
set expandtab
" When using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4
" Show visual line under cursor's current line
" Depending on color theme, this can look good/ugly; 
set cursorline
" Show the matching part of the pair for [], {} and ()
set showmatch
" Enable all python syntax highlighting features
let python_highlight_all = 1


" Can set background here or in color theme; 
" set background=dark
" set background=light
" Many themes require that you set the background;
" But rather than setting here, I think better to set in the theme itself;

" colorscheme monokai
" colorscheme zenburn
" colorscheme gruvbox
" colorscheme gruvbox8_soft
" colorscheme robinhood
