-- General options configuration
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable system clipboard integration
vim.opt.clipboard = "unnamedplus"

-- Display
vim.opt.winborder = "rounded"
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.cursorline = false
vim.opt.showmode = false
vim.opt.scrolloff = 8
vim.opt.wrap = false

-- Search
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Performance
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Persistence
vim.opt.undofile = true

-- Other
vim.opt.spell = false

-- Treesitter folding (Neovim 0.11+)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevelstart = 99
