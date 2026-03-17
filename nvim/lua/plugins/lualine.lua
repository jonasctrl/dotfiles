return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
        local lazy_status = require("lazy.status")

        return {
            options = {
                theme = "dark",
                icons_enabled = true,
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff" },
                lualine_c = {
                    "filename",
                    {
                        "diagnostics",
                        symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
                    },
                },
                lualine_x = {
                    { lazy_status.updates, cond = lazy_status.has_updates },
                    { "encoding" },
                },
                lualine_y = {},
                lualine_z = {},
            },
        }
    end,
}
