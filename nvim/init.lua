-- Global variables
vim = vim
Snacks = Snacks

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

-- Basic keymaps
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save" })

-- save all buffers and quit
vim.keymap.set("n", "<leader>Q", function()
    local bufs = vim.api.nvim_list_bufs()
    for _, buf in ipairs(bufs) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf,
            "modified") then
            vim.api.nvim_buf_call(buf, function()
                vim.cmd("write")
            end)
        end
    end
    vim.cmd("quitall")
end, { desc = "Save all and quit" })

