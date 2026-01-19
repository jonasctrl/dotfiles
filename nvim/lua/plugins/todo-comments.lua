return {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        signs = false,
        highlight = {
            multiline = false,
            before = "",
            keyword = "bg",
            after = "fg",
        },
    },
    keys = {
        { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
        { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous TODO" },
    },
}
