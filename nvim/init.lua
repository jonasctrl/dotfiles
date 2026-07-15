vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazypath) then
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
        }, true, {})
        return
    end
end
vim.opt.rtp:prepend(lazypath)

require("vim-keybinds")
require("vim-options")
require("vim-diagnostic")

require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    install = { colorscheme = { "classic-monokai" } },
    checker = { enabled = false },
    rocks = { enabled = false },
})
