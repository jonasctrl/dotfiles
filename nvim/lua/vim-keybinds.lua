-- Disable bindings
vim.keymap.set("n", "q:", "<nop>")

-- Global keybindings
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
