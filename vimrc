set nocompatible " be iMproved!
"
set shell=/bin/bash
filetype off " required for Vundle, turned back on again later
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"
" Vundle plugins
Plugin 'VundleVim/Vundle.vim' " Tells Vundle to Vundle Vundle (Vundle)
Plugin 'sudar/vim-arduino-syntax' " Syntax highlighting for arduino-cpp
Plugin 'mcchrish/fountain.vim' " Syntac highlighting for fountain
Plugin 'vim-airline/vim-airline' " Vim statusbar
Plugin 'vim-airline/vim-airline-themes' " Themes for above
" Plugin 'edkolev/tmuxline.vim' " Makes the Tmux statusbar match vim-airline
Plugin 'edkolev/promptline.vim' " Makes the shell prompt match vim-airline
Plugin 'takac/vim-hardtime' " Time to break some habits!
Plugin 'tmux-plugins/vim-tmux-focus-events' " Fixes onFocus events lost by tmux
Plugin 'tmux-plugins/vim-tmux' " Syntax highlighting (++) for .tmux.conf
Plugin 'airblade/vim-gitgutter' " Track git-diff of lines in real time
Plugin 'tpope/vim-fugitive' " Git-wrapper for Vim
Plugin 'tpope/vim-scriptease' " A vim plugin for making vim plugins
Plugin 'yuratomo/w3m.vim' " A w3m-based browser inside vim
Plugin 'jparise/vim-graphql' " GraphQL file detection, syntax hl, and indenting
Plugin 'pangloss/vim-javascript' " Better JS highlighting and indenting
Plugin 'mxw/vim-jsx' " JSX highlighting and indentation
Plugin 'chrisbra/Recover.vim' " diff recovery prompt
Plugin 'luochen1990/rainbow' " An amazing technicolor dreamcoat for parens
Plugin 'w0rp/ale' " Lint isn't just for dryers
Plugin 'sevko/vim-nand2tetris-syntax' " NAND2Tetris
Plugin 'rescript-lang/vim-rescript'
Plugin 'morhetz/gruvbox'
Plugin 'laddge/InsEmoji.vim' " Emoji
"
call vundle#end()
filetype on

" Display options
autocmd BufNewFile,BufReadPost *.md set filetype=markdown "Forces .md = markdown
set nu " Turn on line numbering along left side
set scrolloff=2 " Show two lines above or below cursor when at edge of screen
set linebreak " Line wrapping that doesn't split words
set title " Show name of working file.
set showmatch " Highlight matching bracket, parenthesis, etc.
set matchpairs+=<:> " showmatch doesn't include < and > by default apparently
set wildmenu " Enables tab-complete for vim commands
syntax on " turns on colour syntax highlighting
set hlsearch " highlights searchterms in text
set incsearch " highlights search while searching
set laststatus=2 " Forces display of status bar
set lazyredraw " Disables screen redraws during macros
set updatetime=250 " redraws screen 4/sec instead of every 4 seconds
set ttimeoutlen=40 " stops delay exiting to normal mode
let g:rainbow_active = 1 " Turns on rainbow parens
"
" Coloring / theming
" I don't quite understand how but this block makes vim work properly
" with truecolor terminals (as opposed to only 256-color supporting ones)
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
 set termguicolors
endif
"
colorscheme gruvbox
let g:gruvbox_contrast_light='hard'
let g:gruvbox_contrast_dark='hard'
set background=dark
command Drk execute "set background=dark"
command Lgt execute "set background=light"
"
" Vim-Airline options
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'
"
" Editor options
let g:hardtime_default_on = 0 " Auto-enable vim-hardtime (if set to 1)
set backspace=indent,eol,start " needed for cygwin vim iirc
set ignorecase " Case-insensitive searching
  set smartcase " Unless I use a capital in the search intentionally
set smartindent " Use indent sizes used in document at hand
set smarttab " Also recommended for better tab indenting
set magic " Makes vim's regex search patterns line up with grep's
set confirm " Prompts when :w, :q. :wq fail. AFAIK default behaviour
set viminfo='20,\"500 " Copies clipboard registers to .viminfo on quit
set hidden " Remembers undo history after quitting
set history=100 " MOAR UNDO LEVELS!
set tabstop=2 " Show tabs as 2-space indentation
set shiftwidth=2 expandtab " 'soft tabbing' - Hit TAB but GET 2 spaces
set foldopen -=hor " stop opening folds when I hit 'L'

" ALE options
let g:ale_sign_column_always = 1 " Always show ALE gutter

" gitgutter options
if exists('&signcolumn')  " Vim > 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif
