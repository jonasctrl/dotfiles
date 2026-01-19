return {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "BufReadPre",
    opts = {},
    keys = {
        { "<leader>co", "<Plug>(git-conflict-ours)", desc = "Conflict: Choose ours" },
        { "<leader>ct", "<Plug>(git-conflict-theirs)", desc = "Conflict: Choose theirs" },
        { "<leader>cb", "<Plug>(git-conflict-both)", desc = "Conflict: Choose both" },
        { "<leader>c0", "<Plug>(git-conflict-none)", desc = "Conflict: Choose none" },
        { "]x", "<Plug>(git-conflict-next-conflict)", desc = "Conflict: Next" },
        { "[x", "<Plug>(git-conflict-prev-conflict)", desc = "Conflict: Previous" },
    },
}
