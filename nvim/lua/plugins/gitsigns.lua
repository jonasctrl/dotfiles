return {
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

                -- custom mapping to open the commit in browser using snacks.nvim
                map("n", "<leader>ho", function()
                    local line = vim.api.nvim_win_get_cursor(0)[1]
                    local cmd = string.format('git blame -L %d,%d --porcelain %s',
                        line, line,
                        vim.fn.shellescape(vim.fn.expand('%')))
                    local output = vim.fn.system(cmd)
                    local commit = output:match("^(%x+)")
                    if commit and commit ~= "" and commit ~= "0000000000000000000000000000000000000000" then
                        require("snacks").gitbrowse({ commit = commit })
                    else
                        vim.notify("No commit found for this line", vim.log.levels.WARN)
                    end
                end, "Open commit in browser")
            end
        })

        -- Set highlight for current line blame
        vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#6e6e6e", italic = true })
        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function()
                vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#6e6e6e", italic = true })
            end
        })
    end
}
