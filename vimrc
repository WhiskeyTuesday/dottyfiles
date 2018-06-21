set nocompatible " be iMproved!
"
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
Plugin 'edkolev/tmuxline.vim' " Makes the Tmux statusbar match vim-airline
Plugin 'edkolev/promptline.vim' " Makes the shell prompt match vim-airline
Plugin 'takac/vim-hardtime' " Time to break some habits!
Plugin 'tmux-plugins/vim-tmux-focus-events' " Restores onFocus events lost when using tmux
Plugin 'tmux-plugins/vim-tmux' " Syntax highlighting (++) for .tmux.conf
Plugin 'airblade/vim-gitgutter' " Track git-diff status of buffer lines in real time
Plugin 'tpope/vim-fugitive' " Git-wrapper for Vim
Plugin 'tpope/vim-scriptease' " A vim plugin for making vim plugins
Plugin 'yuratomo/w3m.vim' " A w3m-based browser inside vim
call vundle#end()
"
" Display options
filetype on
autocmd BufNewFile,BufReadPost *.md set filetype=markdown "Forces .md to be markdown always
set nu " Turn on line numbering along left side
set scrolloff=2 " Show two lines above or below cursor when at edge of screen
set showmode " Display current mode, I think this may be default behaviour, but in case of old installs/vi I guess
set linebreak " Line wrapping that doesn't split words
set showcmd " Display command line, again, afaik default behaviour
set title " Show name of working file. Same deal as above re: defaults
set showmatch " Highlight matching bracket, parenthesis, etc. ; Same as above re: defaults
set matchpairs+=<:> " showmatch doesn't include < and > by default apparently
set wildmenu " Enables tab-complete for vim commands
syntax on " turns on colour syntax highlighting
set hlsearch " highlights searchterms in text
set incsearch " highlights search while searching
set laststatus=2 " Forces display of status bar
set lazyredraw " Disables screen redraws during macros - good for SSH latency I'd assume
set updatetime=250 " redraws screen 4/sec instead of every 4 seconds
set ttimeoutlen=40 " stops delay exiting to normal mode
"
" Vim-Airline options
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'
"
" Editor options
let g:hardtime_default_on = 0 " Auto-enable vim-hardtime
set backspace=indent,eol,start " Allow backspace over any and all characters - had some issues without this in cygwin vim iirc
set ignorecase " Case-insensitive searching
  set smartcase " Unless I *USE* a capital in the search intentionally
set smartindent " Use indent sizes used in document at hand
set smarttab " Also recommended for better tab indenting, I don't exactly know what this does personally.
set magic " Makes vim's regex search patterns line up with grep's
set confirm " Prompts when :w, :q. :wq fail. AFAIK default behaviour
set viminfo='20,\"500 " Copies clipboard registers to .viminfo on quit
set hidden " Remembers undo history after quitting
set history=50 " MOAR UNDO LEVELS!
set tabstop=4 " Show tabs as 4-space indentation (in case the code is Richard's or something.)
set shiftwidth=4 expandtab " Set 'soft' tabbing. So I can HIT Tab but GET 4 spaces.

" Gitgutter configuration
let g:gitgutter_max_signs = 2000 " For refactoring a certain java codebase, reduce for better performance
