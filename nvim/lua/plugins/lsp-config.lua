return {
    {
        "williamboman/mason.nvim",
        config = true,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "gopls", "ts_ls", "pyright", "marksman", "html", "bashls", "tsgo" },
                automatic_installation = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "williamboman/mason.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local on_attach = function(_, bufnr)
                local opts = { buffer = bufnr }
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            end

            local mason_lspconfig = require("mason-lspconfig")

            mason_lspconfig.setup({
                ensure_installed = { "lua_ls", "gopls", "tsgo", "pyright", "marksman", "html", "cssls", "bashls" },
                automatic_installation = true,
            })

            if mason_lspconfig.setup_handlers then
                mason_lspconfig.setup_handlers({
                    function(server_name)
                        if vim.lsp.configs[server_name] then
                            vim.lsp.configs[server_name].setup({
                                capabilities = capabilities,
                                on_attach = on_attach,
                            })
                        else
                            vim.notify("LSP server not found: " .. server_name, vim.log.levels.WARN)
                        end
                    end,
                })
            end
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
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                },
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                go = { "goimports", "gofmt" },
                lua = { "stylua" },
                typescript = { "prettier" },
                javascript = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                sh = { "shfmt" },
                bash = { "shfmt" },
            },
        },
        config = function(_, opts)
            require("conform").setup(opts)

            -- format code shortcut
            vim.keymap.set("n", "<leader>f", function()
                vim.lsp.buf.format({ async = true })
            end, { desc = "Format buffer" })

            -- format on save
            vim.api.nvim_create_autocmd("BufWritePre", {
                callback = function(args)
                    require("conform").format({ bufnr = args.buf })
                end,
            })
        end,
    },
}
