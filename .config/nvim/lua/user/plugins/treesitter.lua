return {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile' },
    build = ':TSUpdate',
    config = function()
        local treesitter = require('nvim-treesitter.configs')

        treesitter.setup({
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            },
            ensure_installed = {
                'c', -- the first five languages should always be installed
                'lua',
                'vim',
                'vimdoc',
                'query',
                'cpp',
                'python',
                'rust',
                'dockerfile',
                'gitignore',
            },
        })
    end,
}
