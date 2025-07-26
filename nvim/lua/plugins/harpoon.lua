return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add file to harpoon" })
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toggle harpoon menu" })

    -- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, { desc = "Go to harpoon file 1" })
    -- vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end, { desc = "Go to harpoon file 2" })
    -- vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end, { desc = "Go to harpoon file 3" })
    -- vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end, { desc = "Go to harpoon file 4" })

    -- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Previous harpoon file" })
    -- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Next harpoon file" })

    harpoon:extend({
      UI_CREATE = function(cx)
        vim.keymap.set("n", "<C-v>", function()
          harpoon.ui:select_menu_item({ vsplit = true })
        end, { buffer = cx.bufnr, desc = "Open in vertical split" })

        vim.keymap.set("n", "<C-x>", function()
          harpoon.ui:select_menu_item({ split = true })
        end, { buffer = cx.bufnr, desc = "Open in horizontal split" })

        vim.keymap.set("n", "<C-t>", function()
          harpoon.ui:select_menu_item({ tabedit = true })
        end, { buffer = cx.bufnr, desc = "Open in new tab" })
      end,
    })

    local harpoon_extensions = require("harpoon.extensions")
    harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
  end,
}
