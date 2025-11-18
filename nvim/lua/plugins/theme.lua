return {
    "khoido2003/classic_monokai.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("classic_monokai").setup()
        vim.cmd.colorscheme("classic-monokai")

        -- HACK: Disable pane borders by matching background
        local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
        if bg then
            local bg_hex = string.format("#%06x", bg)
            vim.api.nvim_set_hl(0, "VertSplit", { fg = bg_hex, bg = bg_hex })
            vim.api.nvim_set_hl(0, "WinSeparator", { fg = bg_hex, bg = bg_hex })
        end

        -- HACK: Visual theme tweaks for Snacks.nvim to reduce purple and improve readability
        -- Customize directory/folder colors and replace purple with neutral whitish (VS Code-like)
        local fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg
        if fg then
            local fg_hex = string.format("#%06x", fg)

            -- Directories
            vim.api.nvim_set_hl(0, "Directory", { fg = fg_hex })
            vim.api.nvim_set_hl(0, "SnacksPickerDirectory", { fg = fg_hex })

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

            -- Search/match highlights - keep visible but not purple
            vim.api.nvim_set_hl(0, "Special", { fg = fg_hex, bold = true })
            vim.api.nvim_set_hl(0, "@string.special", { fg = fg_hex })
            vim.api.nvim_set_hl(0, "@string.escape", { fg = fg_hex })

            -- INVESTIGATE: Any other purple-based highlights
            -- vim.api.nvim_set_hl(0, "Identifier", { fg = fg_hex })
            -- vim.api.nvim_set_hl(0, "@variable", { fg = fg_hex })
            -- vim.api.nvim_set_hl(0, "@property", { fg = fg_hex })
            -- vim.api.nvim_set_hl(0, "@field", { fg = fg_hex })
        end
    end
}
