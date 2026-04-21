return {
    -- Highlight, indentation, autotagging
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup({})

            require("nvim-treesitter").install({
                "bash",
                "css",
                "go",
                "gomod",
                "gosum",
                "gowork",
                "html",
                "javascript",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "rust",
                "scss",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "vue",
                "yaml",
            })

            -- Enable treesitter highlighting per buffer (skip large files)
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
                    if ok and stats and stats.size > 1024 * 1024 then return end
                    pcall(vim.treesitter.start, args.buf)
                end,
            })

            -- Enable treesitter indentation (skip python)
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    if vim.bo[args.buf].filetype == "python" then return end
                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },

    -- Auto close/rename HTML tags
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPre", "BufNewFile" },
        opts = { opts = { enable_close_on_slash = false } },
    },

    -- Show code context at the top of the window
    {
        "nvim-treesitter/nvim-treesitter-context",
        enabled = true,
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
