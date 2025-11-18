return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "┃" },
                    change = { text = "┃" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked = { text = "┆" },
                },
                current_line_blame = true,
                current_line_blame_opts = { delay = 0 },
                on_attach = function(bufnr)
                    local gs = require("gitsigns")
                    local map = function(mode, l, r, desc)
                        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
                    end

                    map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
                    map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
                    map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle blame")
                    map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
                    map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
                    map("n", "<leader>hd", gs.diffthis, "Diff this")
                end
            })

            -- HACK: This is to ensure the highlight for current line blame is set correctly
            vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#6e6e6e", italic = true })
            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = function()
                    vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#6e6e6e", italic = true })
                end
            })
        end
    },
    {
        'f-person/git-blame.nvim',
        config = function()
            vim.g.gitblame_enabled = 0
            vim.api.nvim_set_keymap('n', '<leader>ho', ':GitBlameOpenCommitURL<CR>',
                { noremap = true, silent = true, desc = "Open commit in browser" })
        end
    }
}
