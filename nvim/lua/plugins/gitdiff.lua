return {
  "sindrets/diffview.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>hd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
    { "<leader>hf", "<cmd>DiffviewFileHistory<cr>", desc = "File History" },
    { "<leader>hc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
  },
  config = function()
    require("diffview").setup({})
  end
}
