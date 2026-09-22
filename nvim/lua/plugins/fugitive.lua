return {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gread", "Gwrite", "Gclog" },
    keys = {
        { "<leader>gg", "<cmd>tab Git<cr>", desc = "Git status" },
        { "<leader>gv", "<cmd>Gvdiffsplit!<cr>", desc = "Git 3-way diff" },
    },
}
