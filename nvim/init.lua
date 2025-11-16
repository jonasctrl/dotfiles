_G.Snacks = {}
-- FIX IT
vim = vim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

pcall(require, "vim-options")
pcall(require("lazy").setup, "plugins")

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- misc
vim.opt.spell = true
vim.opt.clipboard = "unnamedplus"

-- ui
vim.opt.background = "dark"
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.diagnostic.config({
  virtual_text = {
    enabled = true,
    source = "if_many",
    prefix = "",
    spacing = 2,
    severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN },
  },
  signs = false,
  underline = {
    enabled = true,
    severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN },
  },
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
