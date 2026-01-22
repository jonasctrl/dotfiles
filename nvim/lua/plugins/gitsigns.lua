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
            current_line_blame_opts = { delay = 100 },
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

                -- Open blame commit in browser (uses gitsigns blame data)
                map("n", "<leader>ho", function()
                    local blame = vim.b.gitsigns_blame_line_dict
                    if blame and blame.sha and blame.sha ~= string.rep("0", 40) then
                        Snacks.gitbrowse({ what = "commit", commit = blame.sha })
                    else
                        vim.notify("No commit found for this line", vim.log.levels.WARN)
                    end
                end, "Open commit in browser")
            end
        })
    end,
}
