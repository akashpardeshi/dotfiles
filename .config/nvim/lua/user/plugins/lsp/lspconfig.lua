return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        { 'antosha417/nvim-lsp-file-operations', config = true },
        { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
        local lspconfig = require('lspconfig')
        local mason_lspconfig = require('mason-lspconfig')
        local cmp_nvim_lsp = require('cmp_nvim_lsp')
        local keymap = vim.keymap

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }

                opts.desc = 'Show LSP references' -- TODO: why doesn't preview show up in live_grep?
                keymap.set('n', 'fr', '<cmd>Telescope lsp_references show_line=false<CR>', opts)

                opts.desc = 'Go to definition'
                keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)

                opts.desc = 'Show code actions'
                keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

                opts.desc = 'Rename'
                keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

                opts.desc = 'Show diagnostics for line'
                keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)

                opts.desc = 'Show diagnostics for buffer'
                keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)

                opts.desc = 'Show documentation'
                keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            end
        })

        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()

        mason_lspconfig.setup_handlers({
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                })
            end,
        })
    end,
}
