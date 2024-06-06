" Vundle plugins (from my original vim config)
"Plugin 'VundleVim/Vundle.vim' " Tells Vundle to Vundle Vundle (Vundle)
"Plugin 'sudar/vim-arduino-syntax' " Syntax highlighting for arduino-cpp
"Plugin 'mcchrish/fountain.vim' " Syntac highlighting for fountain
"Plugin 'takac/vim-hardtime' " Time to break some habits!
"Plugin 'tmux-plugins/vim-tmux-focus-events' " Fixes onFocus events lost by tmux
"Plugin 'tmux-plugins/vim-tmux' " Syntax highlighting (++) for .tmux.conf
"Plugin 'airblade/vim-gitgutter' " Track git-diff of lines in real time
"Plugin 'tpope/vim-fugitive' " Git-wrapper for Vim
"Plugin 'tpope/vim-scriptease' " A vim plugin for making vim plugins
"Plugin 'yuratomo/w3m.vim' " A w3m-based browser inside vim
"Plugin 'pangloss/vim-javascript' " Better JS highlighting and indenting
"Plugin 'mxw/vim-jsx' " JSX highlighting and indentation
"Plugin 'chrisbra/Recover.vim' " diff recovery prompt
"Plugin 'luochen1990/rainbow' " An amazing technicolor dreamcoat for parens
"Plugin 'w0rp/ale' " Lint isn't just for dryers
"Plugin 'rescript-lang/vim-rescript'
"Plugin 'laddge/InsEmoji.vim' " Emoji

"call vundle#end()
"filetype on

" vim-plug (for neovim)
call plug#begin()
Plug 'rescript-lang/vim-rescript'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox' " Gruvbox theme
Plug 'xero/miasma.nvim' " Miasma theme
Plug 'savq/melange-nvim' " Melange theme
Plug 'Biscuit-Colorscheme/nvim' " Biscuit theme
Plug 'rebelot/kanagawa.vim' " Kanagawa theme
Plug 'EdenEast/nightfox.nvim' " Nightfox (and terafox) theme
Plug 'vim-airline/vim-airline' " Vim statusbar
Plug 'vim-airline/vim-airline-themes' " Themes for above
Plug 'jparise/vim-graphql' " GraphQL file detection, syntax hl, and indenting
Plug 'othree/html5.vim'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
" allow :BD to close buffers without closing windows/splits
Plug 'qpkorr/vim-bufkill', { 'branch': 'master' }
Plug 'github/copilot.vim'
Plug 'mbbill/undotree' " Undo tree
"Plug 'edkolev/tmuxline.vim' " Makes the Tmux statusbar match vim-airline
"Plug 'edkolev/promptline.vim' " Makes the shell prompt match vim-airline
Plug 'sevko/vim-nand2tetris-syntax' " NAND2Tetris
call plug#end()

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
command Drk execute "set background=dark"
command Lgt execute "set background=light"
command D execute "colorscheme desert"
command G execute "colorscheme gruvbox"
command Nf execute "colorscheme nightfox"
command Tf execute "colorscheme terafox"
colorscheme biscuit

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

" Custom commands
cnoreabbrev <expr> T ((getcmdtype() is# ':' && getcmdline() is# 'T')?('NvimTreeToggle'):('T'))

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

command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
      " \ pumvisible() ? "\<C-n>" :
      " \ <SID>check_back_space() ? "\<TAB>" :
      " \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"


" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" use Ctrl-j and Ctrl-k to scroll within the typehint window
nnoremap coc#float#has_scroll() ? coc#float#scroll(1, 1) : "<C-j>"
nnoremap coc#float#has_scroll() ? coc#float#scroll(0, 1) : "<C-k>"

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

lua <<EOF
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
EOF
