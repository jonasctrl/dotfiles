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

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.spell = true
vim.opt.clipboard = "unnamedplus"

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

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { bg = "#472329", fg = "#f87171" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { bg = "#453411", fg = "#fbbf24" })

vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit", silent = true })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save", silent = true })
vim.keymap.set("n", "<leader>Q", "<cmd>wa | qa<CR>", { desc = "Save all and quit", silent = true })
vim.keymap.set("n", "<leader>ss", "<cmd>set spell!<CR>", { desc = "Toggle spell checking", silent = true })
