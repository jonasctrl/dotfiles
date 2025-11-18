return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status")

        lualine.setup({
            options = {
                theme = "ayu_dark",
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
            },
            icons_enabled = true,
            sections = {
                lualine_x = {
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                    },
                    { "encoding" },
                    { "filetype" },
                },
            },
        })
    end,
}
