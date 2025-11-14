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
        end
    }
}
