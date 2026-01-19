-- Enable Lua module caching (Neovim 0.9+)
vim.loader.enable()

-- Set leader key before lazy.nvim loads
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
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

-- Load core configuration
require("vim-keybinds")
require("vim-options")
require("vim-diagnostic")

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    install = { colorscheme = { "classic_monokai" } },
    performance = {
        rtp = {
            disabled_plugins = {
                "tohtml",
                "tutor",
                "2html_plugin",
                "getscript",
                "getscriptPlugin",
                "vimball",
                "vimballPlugin",
            },
        },
    },
    checker = { enabled = false },
})
