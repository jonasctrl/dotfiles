return {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "BufReadPost",
    opts = {},
    keys = {
        { "<leader>co", "<Plug>(git-conflict-ours)", desc = "Conflict: choose ours" },
        { "<leader>ct", "<Plug>(git-conflict-theirs)", desc = "Conflict: choose theirs" },
        { "<leader>cb", "<Plug>(git-conflict-both)", desc = "Conflict: choose both" },
        { "<leader>c0", "<Plug>(git-conflict-none)", desc = "Conflict: choose none" },
        { "]x", "<Plug>(git-conflict-next-conflict)", desc = "Next conflict" },
        { "[x", "<Plug>(git-conflict-prev-conflict)", desc = "Previous conflict" },
    },
}
