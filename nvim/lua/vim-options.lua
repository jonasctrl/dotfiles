-- NOTE: Diagnostic configuration
vim.diagnostic.config({
    virtual_text = {
        source = "if_many",
        prefix = "",
        severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN },
    },
    signs = false,
    underline = {
        severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN },
    },
    update_in_insert = false,
    severity_sort = true,
})

-- NOTE: Leader key
vim.g.mapleader = " "

-- NOTE: Options
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.clipboard = "unnamedplus"

vim.opt.spell = true
vim.opt.background = "dark"
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
