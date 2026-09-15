vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.clipboard = "unnamedplus"

vim.opt.showtabline = 0
vim.opt.winborder = "rounded"
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.cursorline = false
vim.opt.showmode = false
vim.opt.scrolloff = 8
vim.opt.wrap = false

vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.undofile = true
vim.opt.spell = false

vim.keymap.set("n", "q:", "<nop>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.diagnostic.config({
    virtual_text = {
        source = "if_many",
        prefix = "",
        severity = { min = vim.diagnostic.severity.WARN },
    },
    signs = false,
    underline = false,
    update_in_insert = false,
    severity_sort = true,
})
