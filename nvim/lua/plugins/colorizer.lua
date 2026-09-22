return {
    "catgoose/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        options = {
            parsers = {
                css = true,
                names = { enable = false },
            },
        },
    },
}
