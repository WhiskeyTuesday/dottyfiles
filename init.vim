call plug#begin()
" Editor related
Plug 'airblade/vim-gitgutter'
" Plug 'edkolev/tmuxline.vim' " Makes the Tmux statusbar match vim-airline
" Plug 'edkolev/promptline.vim' " Makes the shell prompt match vim-airline
Plug 'vim-airline/vim-airline' " Vim statusbar
" allow :BD to close buffers without closing windows/splits
Plug 'qpkorr/vim-bufkill', { 'branch': 'master' }
Plug 'github/copilot.vim' " disabled in favor of zbirenbaum/copilot.lua
Plug 'mbbill/undotree' " Undo tree
Plug 'neovim/nvim-lspconfig' " https://github.com/neovim/nvim-lspconfig
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-lua/plenary.nvim' " Required for telescope and elixir-tools
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }

" Themes
Plug 'Biscuit-Colorscheme/nvim' " Biscuit theme
Plug 'xero/miasma.nvim' " Miasma theme
Plug 'savq/melange-nvim' " Melange theme
Plug 'EdenEast/nightfox.nvim' " Nightfox (and terafox) theme
Plug 'vim-airline/vim-airline-themes'
Plug 'sainnhe/everforest' " Everforest theme
Plug 'sainnhe/sonokai' " Sonokai theme
Plug 'sainnhe/gruvbox-material' " Gruvbox Material theme

" LSP config and completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Language/tool specific
Plug 'rescript-lang/vim-rescript'
Plug 'jparise/vim-graphql' " GraphQL file detection, syntax hl, and indenting
Plug 'othree/html5.vim'
Plug 'leafOfTree/vim-svelte-plugin'
Plug 'sevko/vim-nand2tetris-syntax' " NAND2Tetris
call plug#end()

runtime airlinecycle.vim " Cycle through airline themes

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
set colorcolumn=60,80 " Highlights columns 60 and 80

let g:neovide_fullscreen = 1 " Fullscreen when using neovide

" Coloring / theming
command Drk set background=dark
command Lgt set background=light
command D colorscheme desert | AirlineTheme zenburn
command G colorscheme gruvbox-material | AirlineTheme zenburn
command Nf colorscheme nightfox | AirlineTheme zenburn
command Tf colorscheme terafox | AirlineTheme zenburn
command Df colorscheme dawnfox | AirlineTheme zenburn
command B colorscheme biscuit | AirlineTheme zenburn
command M colorscheme miasma | AirlineTheme zenburn
command Ml colorscheme melange | AirlineTheme zenburn
command E colorscheme everforest | AirlineTheme zenburn

let g:everforest_enable_italic = 1
let g:everforest_background = 'soft'

let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_background = 'soft'

colorscheme gruvbox-material

try
  AirlineTheme zenburn
catch
  " autocmd VimEnter defers the command until everything is
  " loaded, so it won't complain that AirlineTheme isn't a
  " known command
  autocmd VimEnter * AirlineTheme zenburn
endtry

" font/typeface (for GUIs, neovide in my case)
set guifont=FantasqueSansM\ Nerd\ Font:h13 " curly k master race

" Vim-Airline options
let g:airline_powerline_fonts = 1
let g:airline_theme='term'

" Editor options
"let g:hardtime_default_on = 0 " Auto-enable vim-hardtime (if set to 1)
set backspace=indent,eol,start " needed for cygwin vim iirc
set ignorecase " Case-insensitive searching
set smartcase " Unless I use a capital in the search intentionally
set smartindent " Use indent sizes used in document at hand
set smarttab " Also recommended for better tab indenting
set magic " Makes vim's regex search patterns line up with grep's
set confirm " Prompts when :w, :q. :wq fail. AFAIK default behaviour
set viminfo='20,\"500 " Copies clipboard registers to .viminfo on quit
set hidden " Remembers undo history after quitting
set history=1000 " MOAR UNDO LEVELS!
set tabstop=2 " Show tabs as 2-space indentation
set shiftwidth=2 expandtab " 'soft tabbing' - Hit TAB but GET 2 spaces
set foldopen -=hor " stop opening folds when I hit 'L'

" Set internal encoding of vim, not needed on neovim, since coc.nvim uses some
" unicode characters in the file autoload/float.vim
set encoding=UTF-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Custom functionality
function! ToggleNvimTree()
    let cmd_is_colon = getcmdtype() is# ':'
    let cmd_is_t = getcmdline() is# 'T'
    return (cmd_is_colon && cmd_is_t) ? 'NvimTreeToggle' : 'T'
endfunction
cnoreabbrev <expr> T ToggleNvimTree()

" Language-specific settings

" enable format-on-save from nvim-lspconfig + ZLS
" Formatting with ZLS matches `zig fmt`.
" The Zig FAQ answers some questions about `zig fmt`:
" https://github.com/ziglang/zig/wiki/FAQ
autocmd BufWritePre *.zig,*.zon lua vim.lsp.buf.format()

" vimscript config above will be run before lua/lua_init.lua
lua require('lua_init')

" Anything in this block will be run last (why not just put
" it in lua/lua_init.lua? I don't know but I might I guess)
lua << EOF
EOF
