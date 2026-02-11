local prettier = { "prettierd", "prettier", stop_after_first = true }

local function eslint_config(bufnr)
    return vim.fs.find({
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.cjs",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.json",
        ".eslintrc",
    }, { upward = true, path = vim.api.nvim_buf_get_name(bufnr) })[1] ~= nil
end

local function js_formatter(bufnr)
    if eslint_config(bufnr) then return { lsp_format = "first" } end
    return prettier
end

return {
    {
        "mason-org/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUpdate" },
        build = ":MasonUpdate",
        opts = {},
    },

    {
        "mason-org/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "mason-org/mason.nvim" },
        opts = {
            ensure_installed = {
                "bashls",
                "cssls",
                "eslint",
                "gopls",
                "html",
                "lua_ls",
                "marksman",
                "pyright",
                "vtsls",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            vim.lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local opts = { buffer = args.buf }
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                end,
            })

            vim.lsp.enable("sqlls", false)
        end,
    },

    {
        "saghen/blink.cmp",
        version = "1.*",
        opts = {
            keymap = {
                preset = "none",
                ["<C-n>"] = { "show", "select_next", "fallback" },
                ["<C-p>"] = { "show", "select_prev", "fallback" },
                ["<C-j>"] = { "select_next", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback" },
                ["<Tab>"] = { "accept", "fallback" },
                ["<CR>"] = { "accept", "fallback" },
                ["<C-Space>"] = { "show", "fallback" },
                ["<C-e>"] = { "cancel", "fallback" },
                ["<C-d>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            },
            completion = {
                list = { selection = { preselect = false, auto_insert = false } },
                documentation = { auto_show = true, auto_show_delay_ms = 750 },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                providers = {
                    buffer = { min_keyword_length = 3 },
                },
            },
            fuzzy = { implementation = "prefer_rust" },
        },
        opts_extend = { "sources.default" },
    },

    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>f",
                function() require("conform").format({ async = true }) end,
                mode = "",
                desc = "Format buffer",
            },
        },
        opts = {
            formatters_by_ft = {
                go = { "goimports", "gofmt" },
                lua = { "stylua" },
                typescript = js_formatter,
                javascript = js_formatter,
                typescriptreact = js_formatter,
                javascriptreact = js_formatter,
                vue = js_formatter,
                html = prettier,
                css = prettier,
                json = prettier,
                sh = { "shfmt" },
                bash = { "shfmt" },
                yaml = prettier,
                markdown = prettier,
            },
            default_format_opts = { lsp_format = "fallback" },
            format_on_save = function(bufnr)
                -- NOTE: Disable auto-formatting for certain filetypes
                local no_auto_format = {
                    yaml = true,
                    markdown = true,
                }

                if no_auto_format[vim.bo[bufnr].filetype] then return nil end
                return { timeout_ms = 1000 }
            end,
            notify_on_error = true,
        },
        init = function() vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" end,
    },
}
