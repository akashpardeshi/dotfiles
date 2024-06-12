return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'nvim-telescope/telescope-live-grep-args.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        local telescope = require('telescope')

        telescope.setup({
            defaults = {
                layout_config = {
                    prompt_position = 'top',
                },
                sorting_strategy = 'ascending',
            },
            extensions = {
                live_grep_args = {
                    auto_quoting = false,
                },
            },
        })

        telescope.load_extension('fzf')
        telescope.load_extension('live_grep_args')

        local keymap = vim.keymap
        vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>',
            { desc = 'Search for file' })
        vim.keymap.set('n', '<leader>fs', '<cmd>Telescope live_grep<CR>',
            { desc = 'Search for string' })
        vim.keymap.set('n', '<leader>fc', '<cmd>Telescope grep_string<CR>',
            { desc = 'Search for string under cursor' })
        -- vim.keymap.set('n', '<leader>fr', '<cmd>Telescope lsp_references show_line=false<CR>',
        --     { desc = 'Search for references of string under cursor' })
        vim.keymap.set('n', '<leader>rg', '<cmd>Telescope live_grep_args<CR>',
            { desc = 'Search with ripgrep args' })
    end,
}
