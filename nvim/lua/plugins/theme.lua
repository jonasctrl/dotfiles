local function custom_monokai()
    local fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg
    local fg_hex = fg and string.format("#%06x", fg) or "#f8f8f2"
    local bg = "#161616"
    local hl = vim.api.nvim_set_hl

    -- Background overrides
    hl(0, "Normal", { fg = fg, bg = bg })
    hl(0, "NormalFloat", { fg = fg, bg = bg })
    hl(0, "NormalNC", { fg = fg, bg = bg })
    hl(0, "SignColumn", { bg = bg })
    hl(0, "StatusLine", { bg = bg })
    hl(0, "StatusLineNC", { bg = bg })

    -- Hide window borders
    hl(0, "WinSeparator", { fg = bg, bg = bg })
    hl(0, "SnacksWinSeparator", { fg = bg, bg = bg })
    hl(0, "SnacksExplorerWinSeparator", { fg = bg, bg = bg })
    hl(0, "SnacksNormal", { bg = bg })
    hl(0, "SnacksExplorerNormal", { bg = bg })

    -- Treesitter context
    hl(0, "TreesitterContext", { bg = bg })
    hl(0, "TreesitterContextLineNumber", { fg = "#666666" })
    hl(0, "TreesitterContextBottom", { underline = false })
    hl(0, "TreesitterContextLineNumberBottom", { underline = false })
    hl(0, "TreesitterContextSeparator", { fg = bg })

    -- Directory colors
    hl(0, "Directory", { fg = "#e6a852", bold = true })
    hl(0, "SnacksPickerDirectory", { fg = "#d4a347" })
    hl(0, "SnacksExplorerDir", { fg = "#e6a852", bold = true })
    hl(0, "SnacksExplorerDirOpen", { fg = "#f2c55c", bold = true })
    hl(0, "SnacksExplorerFile", { fg = fg_hex })

    -- Explorer cursor
    hl(0, "SnacksExplorerCursorLine", { bg = "#2d2a2e" })
    hl(0, "SnacksExplorerCursor", { bg = "#3a3739" })

    -- Replace purple highlights with neutral colors
    hl(0, "Constant", { fg = fg_hex })
    hl(0, "@constant", { fg = fg_hex })
    hl(0, "SnacksPickerPrompt", { fg = fg_hex })
    hl(0, "SnacksPickerLabel", { fg = fg_hex })
    hl(0, "SnacksPickerSpecial", { fg = fg_hex })
    hl(0, "SnacksPickerMatch", { fg = fg_hex, bold = true })
    hl(0, "SnacksNotifierInfo", { fg = fg_hex })
    hl(0, "SnacksNotifierIconInfo", { fg = fg_hex })

    -- Indent guides
    hl(0, "SnacksIndent", { fg = "#3a3739" })
    hl(0, "SnacksIndentScope", { fg = "#5a5a5a" })

    -- Gitsigns
    hl(0, "GitSignsCurrentLineBlame", { fg = "#6e6e6e", italic = true })
end

return {
    "khoido2003/classic_monokai.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("classic_monokai").setup()
        vim.cmd.colorscheme("classic-monokai")
        custom_monokai()
    end,
}
