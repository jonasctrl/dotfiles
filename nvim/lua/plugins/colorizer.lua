-- NOTE: Plugin that allows color codes to be highlighted in the editor
return {
    "norcalli/nvim-colorizer.lua",
    enabled = false,
    event = "VeryLazy",
    config = function()
        require("colorizer").setup({
            "*",
            css = { rgb_fn = true },
            html = { names = false },
        })
    end,
}
