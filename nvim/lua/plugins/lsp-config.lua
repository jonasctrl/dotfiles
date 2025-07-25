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
        ensure_installed = { "lua_ls", "gopls", "ts_ls", "pyright" },
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
      end

      local mason_lspconfig = require("mason-lspconfig")

      if mason_lspconfig.setup_handlers then
        mason_lspconfig.setup_handlers({
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
              on_attach = on_attach,
            })
          end,
        })
      else
        local servers = { "lua_ls", "gopls", "ts_ls", "pyright" }
        for _, server in ipairs(servers) do
          lspconfig[server].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end
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
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)

      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end,
      })
    end,
  },
}
