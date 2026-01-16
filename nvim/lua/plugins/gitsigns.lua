return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
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

                -- Navigation
                map("n", "]h", function() gs.nav_hunk("next") end, "Next hunk")
                map("n", "[h", function() gs.nav_hunk("prev") end, "Previous hunk")

                -- Actions
                map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
                map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
                map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage hunk")
                map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset hunk")
                map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
                map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
                map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
                map("n", "<leader>hd", gs.diffthis, "Diff this")
                map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff against ~")
                map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle blame")

                -- HACK: Custom mapping to open the commit in browser using snacks.nvim
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

        -- HACK: This is to ensure the highlight for current line blame is set correctly
        vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#6e6e6e", italic = true })
        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function()
                vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#6e6e6e", italic = true })
            end
        })
    end
}
