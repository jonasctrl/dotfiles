return {
    -- {
    -- "navarasu/onedark.nvim",
    -- priority = 1000,
    -- config = function()
    --     require('onedark').setup {
    --         style = 'darker'
    --     }
    --
    --     require('onedark').load()
    -- end
    -- },
    {
        "khoido2003/classic_monokai.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("classic_monokai").setup()
            vim.cmd.colorscheme("classic-monokai")

            -- Disable pane borders by matching background
            local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
            if bg then
                local bg_hex = string.format("#%06x", bg)
                vim.api.nvim_set_hl(0, "VertSplit", { fg = bg_hex, bg = bg_hex })
                vim.api.nvim_set_hl(0, "WinSeparator", { fg = bg_hex, bg = bg_hex })
            end
        end
    }
}
