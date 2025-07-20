local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system(
    { "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")

vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.spell = true
vim.opt.clipboard = "unnamedplus"

-- Diagnostic display
vim.diagnostic.config({
  virtual_text = {
    enabled = true,
    source = "if_many",
    prefix = "",
    spacing = 2,
    severity_sort = true,
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

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", {
  bg = "#472329",
  fg = "#f87171"
})
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", {
  bg = "#453411",
  fg = "#fbbf24"
})

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
