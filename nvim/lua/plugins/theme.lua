return {
    "khoido2003/classic_monokai.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("classic_monokai").setup()
        vim.cmd.colorscheme("classic-monokai")

        -- HACK: Disable pane borders by matching background
        local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
        local bg_hex = bg and string.format("#%06x", bg) or "#1e1e1e"

        vim.api.nvim_set_hl(0, "VertSplit", { fg = bg_hex, bg = bg_hex })
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = bg_hex, bg = bg_hex })

        -- HACK: Visual theme tweaks for Snacks.nvim to reduce purple color and improve readability
        local fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg
        if fg then
            local fg_hex = string.format("#%06x", fg)

            -- Treesitter context - make it subtle
            vim.api.nvim_set_hl(0, "TreesitterContext", { bg = bg_hex })
            vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { fg = "#666666" })
            vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = false })
            vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { underline = false })
            vim.api.nvim_set_hl(0, "TreesitterContextSeparator", { fg = bg_hex })

            -- Directories - Cohesive color palette for explorer
            local dir_closed = "#e6a852"
            local dir_open = "#f2c55c"
            local dir_picker = "#d4a347"

            -- Standard directory colors
            vim.api.nvim_set_hl(0, "Directory", { fg = dir_closed, bold = true })

            -- Picker directory colors
            vim.api.nvim_set_hl(0, "SnacksPickerDirectory", { fg = dir_picker })

            -- Explorer-specific highlights for better visual hierarchy
            vim.api.nvim_set_hl(0, "SnacksExplorerDir", { fg = dir_closed, bold = true })
            vim.api.nvim_set_hl(0, "SnacksExplorerDirOpen", { fg = dir_open, bold = true })
            vim.api.nvim_set_hl(0, "SnacksExplorerFile", { fg = fg_hex })

            -- Cursor line in explorer - subtle highlight
            vim.api.nvim_set_hl(0, "SnacksExplorerCursorLine", { bg = "#2d2a2e" })
            vim.api.nvim_set_hl(0, "SnacksExplorerCursor", { bg = "#3a3739" })

            -- Replace purple highlights with neutral colors
            vim.api.nvim_set_hl(0, "Constant", { fg = fg_hex })
            vim.api.nvim_set_hl(0, "@constant", { fg = fg_hex })

            -- All Snacks elements that use purple
            vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = fg_hex })
            vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = fg_hex })
            vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = fg_hex })
            vim.api.nvim_set_hl(0, "SnacksPickerPrompt", { fg = fg_hex })
            vim.api.nvim_set_hl(0, "SnacksPickerLabel", { fg = fg_hex })
            vim.api.nvim_set_hl(0, "SnacksPickerSpecial", { fg = fg_hex })

            -- Make matching text slightly brighter/bold for visibility
            vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = fg_hex, bold = true })
            vim.api.nvim_set_hl(0, "SnacksNotifierInfo", { fg = fg_hex })
            vim.api.nvim_set_hl(0, "SnacksNotifierIconInfo", { fg = fg_hex })

            -- Snacks indent guides - subtle but visible
            vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#3a3739" })
            vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#5a5a5a" })
        end

        -- Gitsigns blame - subtle
        vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#6e6e6e", italic = true })
    end
}
