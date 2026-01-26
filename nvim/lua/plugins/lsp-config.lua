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
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUpdate" },
        build = ":MasonUpdate",
        opts = {},
    },

    {
        "williamboman/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "williamboman/mason.nvim" },
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
                "ts_ls",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            vim.lsp.config("*", {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local opts = { buffer = args.buf }
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                end,
            })

            vim.lsp.enable("sqlls", false)
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        opts = function()
            local cmp = require("cmp")
            return {
                snippet = {
                    expand = function(args) vim.snippet.expand(args.body) end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                }, {
                    { name = "buffer", keyword_length = 3 },
                    { name = "path" },
                }),
            }
        end,
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
