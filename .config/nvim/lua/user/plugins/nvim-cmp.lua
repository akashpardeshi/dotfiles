return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        {
            'L3MON4D3/LuaSnip',
            version = 'v2.*',
            build = 'make install_jsregexp',
        },
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
        'onsails/lspkind.nvim',
    },
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local lspkind = require('lspkind')

        require('luasnip.loaders.from_vscode').lazy_load()

        cmp.setup({
            completion = {
                completeopt = 'menu,menuone,preview,noselect'
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-x>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'path' },
            }),
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipses_char = '...',
                }),
            },
        })

        -- cycle through fields in snippets
        local opts = { noremap = true, silent = true }
        vim.api.nvim_set_keymap('i', '<C-k>', "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
        vim.api.nvim_set_keymap('s', '<C-k>', "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
        vim.api.nvim_set_keymap('i', '<C-j>', "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
        vim.api.nvim_set_keymap('s', '<C-j>', "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
    end,
}
