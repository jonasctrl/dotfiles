-- NOTE: Disable native bindings
vim.keymap.set("n", "q:", "<nop>")

-- NOTE: Global keybindings
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
