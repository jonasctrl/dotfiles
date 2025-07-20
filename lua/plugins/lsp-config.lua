return { {
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup()
  end
}, {
  "williamboman/mason-lspconfig.nvim",
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "gopls", "ts_ls", "pyright" }
    })
  end
}, {
  "lukas-reineke/lsp-format.nvim",
  config = function()
    require("lsp-format").setup()
  end
}, {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    local lsp_format = require("lsp-format")

    -- Common on_attach function to integrate lsp-format
    local on_attach = function(client, bufnr)
      lsp_format.on_attach(client)

      -- Keybinding for LSP hover documentation
      vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", {
        noremap = true,
        silent = true
      })

      -- Keybinding to format code
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", {
        noremap = true,
        silent = true
      })
    end

    -- Configure the Lua LSP server
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }           -- Recognize 'vim' as a global variable
          },
          telemetry = {
            enable = false             -- Disable telemetry data
          }
        }
      }
    })

    -- Configure the Go LSP server
    lspconfig.gopls.setup({
      on_attach = on_attach
    })

    -- Configure the TypeScript LSP server
    lspconfig.ts_ls.setup({
      on_attach = on_attach
    })

    -- Configure the Python LSP server
    lspconfig.pyright.setup({
      on_attach = on_attach
    })
  end
} }
