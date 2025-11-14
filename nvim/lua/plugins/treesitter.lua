return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    config = function()
        -- Setup treesitter for various languages
        -- Highlight, indentation, autotagging
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "lua",
                "vim",
                "vimdoc",
                "javascript",
                "typescript",
                "vue",
                "html",
                "css",
                "json",
                "python",
                "go",
                "gomod",
                "gowork",
                "markdown",
                "markdown_inline",
                "bash",
                "yaml",
                "toml",
            },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
            autotag = { enable = true },
        })
    end,
}
