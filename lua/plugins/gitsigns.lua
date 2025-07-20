return { {
  "lewis6991/gitsigns.nvim",
  dependencies = { "nvim-lua/plenary.nvim" }, -- Required dependency
  config = function()
    require("gitsigns").setup({
      signs = {
        add = {
          text = "┃"
        },
        change = {
          text = "┃"
        },
        delete = {
          text = "_"
        },
        topdelete = {
          text = "‾"
        },
        changedelete = {
          text = "~"
        },
        untracked = {
          text = "┆"
        }
      },
      signcolumn = true,       -- Show git signs in the sign column
      numhl = false,           -- Disable line number highlighting
      linehl = false,          -- Disable line highlighting
      word_diff = false,       -- Disable word diff mode

      -- Always show inline git blame
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",         -- 'eol' | 'overlay' | 'right_align'
        delay = 0,                     -- Show blame instantly
        ignore_whitespace = false,
        virt_text_priority = 100
      },
      current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",

      -- Keybindings
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({
              "]c",
              bang = true
            })
          else
            gitsigns.nav_hunk("next")
          end
        end)

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({
              "[c",
              bang = true
            })
          else
            gitsigns.nav_hunk("prev")
          end
        end)

        map("n", "<leader>tb", gitsigns.toggle_current_line_blame)

        vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "CursorHold" }, {
          buffer = bufnr,
          callback = function()
            gitsigns.refresh()
          end
        })
      end
    })
  end
} }
