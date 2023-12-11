require("mason").setup()
require("mason-lspconfig").setup()
local cmp = require'cmp'
local luasnip = require 'luasnip'
cmp.setup({
    snippet = {
        expand = function(args)
             require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
         completion = cmp.config.window.bordered(),
         documentation = cmp.config.window.bordered(),
     },
     mapping = cmp.mapping.preset.insert({
         ['<C-n>'] = cmp.mapping.select_next_item(),
         ['<C-p>'] = cmp.mapping.select_prev_item(),
         ['<C-b>'] = cmp.mapping.scroll_docs(-4),
         ['<C-f>'] = cmp.mapping.scroll_docs(4),
         ['<C-Space>'] = cmp.mapping.complete(),
         ['<C-e>'] = cmp.mapping.abort(),
         ['<CR>'] = cmp.mapping.confirm({ select = true }),

         ['<Tab>'] = cmp.mapping(function(fallback)
             if cmp.visible() then
                 cmp.select_next_item()
             elseif luasnip.expand_or_locally_jumpable() then
                 luasnip.expand_or_jump()
             else
                 fallback()
             end
         end, { 'i', 's' }),
         ['<S-Tab>'] = cmp.mapping(function(fallback)
             if cmp.visible() then
                 cmp.select_prev_item()
             elseif luasnip.locally_jumpable(-1) then
                 luasnip.jump(-1)
             else
                 fallback()
             end
         end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
         { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
})

cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'git' },
    }, {
        { name = 'buffer' },
    })
})
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
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
    })
})

require'luasnip'.filetype_extend("ruby", {"rails"})
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}
-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig').lua_ls.setup {
    capabilities = capabilities
}
require('lspconfig').rust_analyzer.setup {
    capabilities = capabilities
}
require('lspconfig').pyright.setup {
    capabilities = capabilities
}
require('lspconfig').clangd.setup {
    capabilities = capabilities
}
