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
  map('n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
  -- map('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
  map('n','<leader>ee','<cmd>lua vim.diagnostic.open_float()<CR>')
  -- map('n','<leader>ar','<cmd>lua vim.lsp.buf.rename()<CR>')
  map('n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
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
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
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

lspconfig.svelte.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    svelte = {
      plugin = {
        html = { completions = { enable = true } },
        svelte = { completions = { enable = true } },
      }
    }
  }
}

-- Helper function to get command with fallback
local function get_cmd_with_fallback(local_cmd, global_cmd)
  -- First try to find the local version
  local local_exists = vim.fn.executable(vim.fn.getcwd() .. '/node_modules/.bin/' .. local_cmd) == 1
  if local_exists then
    return { "pnpm", "exec", local_cmd, "--stdio" }
  end

  -- Fallback to global version if it exists
  local global_exists = vim.fn.executable(global_cmd) == 1
  if global_exists then
    return { global_cmd, "--stdio" }
  end

  -- Default back to trying local with pnpm exec
  return { "pnpm", "exec", local_cmd, "--stdio" }
end

-- Set higher max listeners for Node processes
local function setup_node_process(client)
  if client.config.cmd and client.config.cmd[1] == "node" then
    table.insert(client.config.cmd, 2, "--max-old-space-size=8192")
    table.insert(client.config.cmd, 2, "--max-listeners=20")
  end
end

lspconfig.ts_ls.setup {
  -- this seems dumb, why are we falling back to the same command? TODO
  cmd = get_cmd_with_fallback("typescript-language-server", "typescript-language-server"),
  on_init = setup_node_process,

  before_init = function(params)
    params.processId = vim.NIL
  end,

  settings = {
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    },

    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    }
  }
}

-- ESLint LSP setup matching your working ts_ls configuration
lspconfig.eslint.setup {
  -- Match the command format that's working for ts_ls in your setup
  cmd = { "pnpm", "exec", "vscode-eslint-language-server", "--stdio" },
  -- Use the same root_dir logic that ts_ls is successfully using
  root_dir = lspconfig.util.find_package_json_ancestor,

  settings = {
    workingDirectory = { mode = "auto" },
    format = true,
    quiet = false,
    onIgnoredFiles = "off",
    rulesCustomizations = {},
    run = "onType",
    workingDirectories = { mode = "auto" }
  },

  handlers = {
    -- Add handlers to debug attachment issues
    ["window/showMessageRequest"] = function(_, result, params)
      vim.notify("ESLint message: " .. vim.inspect(params), vim.log.levels.INFO)
    end,
    ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
      vim.notify("Got ESLint diagnostics", vim.log.levels.INFO)
      vim.lsp.handlers["textDocument/publishDiagnostics"](_, result, ctx, config)
    end,
  },
  on_attach = function(client, bufnr)
    vim.notify("ESLint attached to buffer: " .. bufnr)
  end
}
