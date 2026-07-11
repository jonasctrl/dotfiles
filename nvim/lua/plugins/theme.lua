local function custom_monokai()
    local fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg
    local fg_hex = fg and string.format("#%06x", fg) or "#f8f8f2"
    local bg = "NONE"
    local hl = vim.api.nvim_set_hl

    -- Background overrides
    hl(0, "Normal", { fg = fg, bg = bg })
    hl(0, "NormalFloat", { fg = fg, bg = bg })
    hl(0, "NormalNC", { fg = fg, bg = bg })
    hl(0, "SignColumn", { bg = bg })
    hl(0, "StatusLine", { bg = "NONE" })
    hl(0, "StatusLineNC", { bg = "NONE" })

    -- Hide window borders
    hl(0, "WinSeparator", { fg = "#3a3739", bg = bg })
    hl(0, "MsgSeparator", { fg = "#3a3739", bg = bg })
    hl(0, "SnacksWinSeparator", { fg = "#3a3739", bg = bg })
    hl(0, "SnacksNormal", { bg = bg })

    -- Treesitter context
    hl(0, "TreesitterContext", { bg = bg })
    hl(0, "TreesitterContextLineNumber", { fg = "#666666" })
    hl(0, "TreesitterContextBottom", { underline = false })
    hl(0, "TreesitterContextLineNumberBottom", { underline = false })
    hl(0, "TreesitterContextSeparator", { fg = bg })

    -- Directory colors
    hl(0, "Directory", { fg = "#e6a852", bold = true })
    hl(0, "SnacksPickerDirectory", { fg = "#d4a347" })

    -- Snacks picker transparency
    hl(0, "SnacksPicker", { bg = bg })
    hl(0, "SnacksPickerBorder", { bg = bg })
    hl(0, "SnacksPickerTitle", { bg = bg })
    hl(0, "SnacksPickerFooter", { bg = bg })
    hl(0, "SnacksPickerInput", { bg = bg })
    hl(0, "SnacksPickerInputBorder", { bg = bg })
    hl(0, "SnacksPickerInputTitle", { bg = bg })
    hl(0, "SnacksPickerList", { bg = bg })
    hl(0, "SnacksPickerListBorder", { bg = bg })
    hl(0, "SnacksPickerListTitle", { bg = bg })
    hl(0, "SnacksPickerPreview", { bg = bg })
    hl(0, "SnacksPickerPreviewBorder", { bg = bg })
    hl(0, "SnacksPickerPreviewTitle", { bg = bg })
    hl(0, "SnacksPickerBox", { bg = bg })
    hl(0, "SnacksPickerBoxBorder", { bg = bg })
    hl(0, "SnacksPickerBoxTitle", { bg = bg })
    hl(0, "FloatBorder", { bg = bg })
    hl(0, "FloatTitle", { bg = bg })
    hl(0, "FloatFooter", { bg = bg })

    -- Replace purple highlights with neutral colors
    hl(0, "Constant", { fg = fg_hex })
    hl(0, "@constant", { fg = fg_hex })
    hl(0, "SnacksPickerPrompt", { fg = fg_hex })
    hl(0, "SnacksPickerLabel", { fg = fg_hex })
    hl(0, "SnacksPickerSpecial", { fg = fg_hex })
    hl(0, "SnacksPickerMatch", { fg = fg_hex, bold = true })

    -- Gitsigns
    hl(0, "GitSignsCurrentLineBlame", { fg = "#6e6e6e", italic = true })

    -- Neo-tree
    hl(0, "NeoTreeNormal", { fg = fg_hex, bg = bg })
    hl(0, "NeoTreeNormalNC", { fg = fg_hex, bg = bg })
    hl(0, "NeoTreeEndOfBuffer", { fg = bg, bg = bg })
    hl(0, "NeoTreeWinSeparator", { fg = "#3a3739", bg = bg })
    hl(0, "NeoTreeDirectoryName", { fg = "#e6a852", bold = true })
    hl(0, "NeoTreeDirectoryIcon", { fg = "#e6a852" })
    hl(0, "NeoTreeRootName", { fg = "#f2c55c", bold = true })
    hl(0, "NeoTreeFileName", { fg = fg_hex })
    hl(0, "NeoTreeCursorLine", { bg = "#2d2a2e" })
    hl(0, "NeoTreeTitleBar", { fg = fg_hex, bg = bg })
    hl(0, "NeoTreeFloatTitle", { fg = "#e6a852", bg = bg, bold = true })
    hl(0, "NeoTreeFloatBorder", { fg = "#3a3739", bg = bg })
    hl(0, "NeoTreeFloatNormal", { fg = fg_hex, bg = bg })
    hl(0, "NeoTreeIndentMarker", { fg = "#3a3739" })
    hl(0, "NeoTreeExpander", { fg = "#5a5a5a" })
    hl(0, "NeoTreeGitAdded", { fg = "#b6e27a" })
    hl(0, "NeoTreeGitModified", { fg = "#e6a852" })
    hl(0, "NeoTreeGitUntracked", { fg = "#9ecbff" })
    hl(0, "NeoTreeGitDeleted", { fg = "#ff8f8f" })
    hl(0, "NeoTreeGitConflict", { fg = "#ff8f8f", bold = true })
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
