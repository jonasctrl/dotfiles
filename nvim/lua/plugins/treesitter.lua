return {
    {
        -- NOTE: Setup treesitter for various languages
        -- Highlight, indentation, autotagging
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    "javascript",
                    "typescript",
                    "tsx",
                    "vue",
                    "html",
                    "css",
                    "json",
                    "python",
                    "go",
                    "gomod",
                    "gowork",
                    "gosum",
                    "markdown",
                    "markdown_inline",
                    "bash",
                    "yaml",
                    "toml",
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    disable = function(_, buf)
                        local max_filesize = 1024 * 1024
                        ---@diagnostic disable-next-line: undefined-field
                        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,
                    disable = { "python" },
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = false,
                        node_decremental = "<bs>",
                    },
                },
            })
        end,
    },

    -- Auto close/rename HTML tags
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            opts = {
                enable_close_on_slash = false,
            },
        },
    },

    -- Show code context at the top of the window
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            max_lines = 3,
            multiline_threshold = 1,
            separator = nil,
        },
        keys = {
            { "[c", function() require("treesitter-context").go_to_context() end, desc = "Go to context" },
        },
    },
}
