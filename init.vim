" vim-plug (for neovim)
call plug#begin()
Plug 'rescript-lang/vim-rescript'
Plug 'morhetz/gruvbox' " Gruvbox theme
Plug 'xero/miasma.nvim' " Miasma theme
Plug 'savq/melange-nvim' " Melange theme
Plug 'Biscuit-Colorscheme/nvim' " Biscuit theme
Plug 'EdenEast/nightfox.nvim' " Nightfox (and terafox) theme
Plug 'vim-airline/vim-airline' " Vim statusbar
Plug 'vim-airline/vim-airline-themes' " Themes for above
Plug 'jparise/vim-graphql' " GraphQL file detection, syntax hl, and indenting
Plug 'othree/html5.vim'
Plug 'leafOfTree/vim-svelte-plugin'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
" allow :BD to close buffers without closing windows/splits
Plug 'qpkorr/vim-bufkill', { 'branch': 'master' }
Plug 'github/copilot.vim'
Plug 'mbbill/undotree' " Undo tree
Plug 'sevko/vim-nand2tetris-syntax' " NAND2Tetris
Plug 'neovim/nvim-lspconfig' " https://github.com/neovim/nvim-lspconfig
" Plug 'edkolev/tmuxline.vim' " Makes the Tmux statusbar match vim-airline
" Plug 'edkolev/promptline.vim' " Makes the shell prompt match vim-airline

" LSP config and completion
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'
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

" enable format-on-save from nvim-lspconfig + ZLS
" Formatting with ZLS matches `zig fmt`.
" The Zig FAQ answers some questions about `zig fmt`:
" https://github.com/ziglang/zig/wiki/FAQ
autocmd BufWritePre *.zig,*.zon lua vim.lsp.buf.format()

lua << EOF
-- nvim-tree.lua
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

-- Set up nvim-cmp.
local cmp = require'cmp'

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = 'rounded' }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = 'rounded' }
)

local map = function(type, key, value)
	vim.api.nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true});
end

-- NOTE: I could and maybe should gate each of these behind
-- something like if client.supports_method('textDocument/hover') then
-- but I'm not going to for now

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(client)
    -- NOTE: also the neovim lsp documentation claims that
    -- some of these are set by default but they don't seem
    -- to be for me, and I couldn't figure out why
    map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
    map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
    map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
    map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
    map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
    map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
    map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
    -- map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
    -- map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
    -- map('n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
    -- map('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
    -- map('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
    -- map('n','<leader>ar','<cmd>lua vim.lsp.buf.rename()<CR>')
    -- map('n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    -- map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
    -- map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
  end
})

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
     -- Set `select` to `false` to only confirm explicitly selected items.
     -- i.e. not just accept the first suggestion.
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  }),

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})
require("cmp_git").setup() ]]--

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Set default client capabilities so I don't have to add
-- `capabilities = capabilities` to each server config.

lspconfig.util.default_config = vim.tbl_extend(
  'force',
  lspconfig.util.default_config,
  {
    capabilities = capabilities,
  }
)

lspconfig.zls.setup {
  -- Server-specific settings. See `:help lspconfig-setup`

  -- omit the following line if `zls` is in your PATH
  -- cmd = { '/path/to/zls_executable' },
  -- There are two ways to set config options:
  --   - edit your `zls.json` that applies to any editor that uses ZLS
  --   - set in-editor config options with the `settings` field below.

  -- Further information on how to configure ZLS:
  -- https://zigtools.org/zls/configure/
  settings = {
    zls = {
      -- Whether to enable build-on-save diagnostics

      -- Further information about build-on save:
      -- https://zigtools.org/zls/guides/build-on-save/
      -- enable_build_on_save = true,

      -- omit the following line if `zig` is in your PATH
      -- zig_exe_path = '/path/to/zig_executable'
    }
  }
}

EOF
