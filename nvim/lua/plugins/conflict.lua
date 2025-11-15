return {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = function()
        require('git-conflict').setup()

        vim.keymap.set('n', '<leader>co', '<Plug>(git-conflict-ours)', { desc = 'Conflict: Choose ours' })
        vim.keymap.set('n', '<leader>ct', '<Plug>(git-conflict-theirs)', { desc = 'Conflict: Choose theirs' })
        vim.keymap.set('n', '<leader>cb', '<Plug>(git-conflict-both)', { desc = 'Conflict: Choose both' })
        vim.keymap.set('n', '<leader>c0', '<Plug>(git-conflict-none)', { desc = 'Conflict: Choose none' })
        vim.keymap.set('n', ']x', '<Plug>(git-conflict-next-conflict)', { desc = 'Conflict: Next conflict' })
        vim.keymap.set('n', '[x', '<Plug>(git-conflict-prev-conflict)', { desc = 'Conflict: Previous conflict' })
    end,
    event = "BufReadPre",
}
