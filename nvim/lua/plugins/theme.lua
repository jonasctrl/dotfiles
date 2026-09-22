local function clear_bg(group)
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false }) --[[@as vim.api.keyset.highlight]]
    hl.bg, hl.ctermbg = "NONE", nil
    vim.api.nvim_set_hl(0, group, hl)
end

local transparent = {
    "Normal",
    "NormalFloat",
    "NormalNC",
    "SignColumn",
    "StatusLine",
    "StatusLineNC",
    "TreesitterContext",
    "SnacksNormal",
    "FloatBorder",
    "FloatTitle",
    "FloatFooter",
}

for _, pane in ipairs({
    "",
    "Border",
    "Title",
    "Footer",
    "Input",
    "InputBorder",
    "InputTitle",
    "List",
    "ListBorder",
    "ListTitle",
    "Preview",
    "PreviewBorder",
    "PreviewTitle",
    "Box",
    "BoxBorder",
    "BoxTitle",
}) do
    transparent[#transparent + 1] = "SnacksPicker" .. pane
end

local function custom_monokai()
    local hl = vim.api.nvim_set_hl
    local fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg
    local fg_hex = fg and ("#%06x"):format(fg) or "#f8f8f2"

    for _, group in ipairs(transparent) do
        clear_bg(group)
    end

    for _, group in ipairs({ "WinSeparator", "MsgSeparator", "SnacksWinSeparator" }) do
        hl(0, group, { fg = "#3a3739", bg = "NONE" })
    end

    for _, group in ipairs({
        "Constant",
        "@constant",
        "SnacksPickerPrompt",
        "SnacksPickerLabel",
        "SnacksPickerSpecial",
    }) do
        hl(0, group, { fg = fg_hex })
    end
    hl(0, "SnacksPickerMatch", { fg = fg_hex, bold = true })

    hl(0, "TreesitterContextLineNumber", { fg = "#666666" })
    hl(0, "TreesitterContextBottom", { underline = false })
    hl(0, "TreesitterContextLineNumberBottom", { underline = false })
    hl(0, "TreesitterContextSeparator", { fg = "NONE" })

    hl(0, "Directory", { fg = "#e6a852", bold = true })
    hl(0, "SnacksPickerDirectory", { fg = "#d4a347" })
    hl(0, "SnacksPickerPathHidden", { fg = "#6e6e6e" })

    hl(0, "GitSignsCurrentLineBlame", { fg = "#6e6e6e", italic = true })
end

return {
    "khoido2003/classic_monokai.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("classic_monokai").setup()
        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "classic-monokai",
            callback = custom_monokai,
        })
        vim.cmd.colorscheme("classic-monokai")
    end,
}
