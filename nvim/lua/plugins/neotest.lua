return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-go",
    },
    enabled = false,
    keys = {
        { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
        { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
        { "<leader>ta", function() require("neotest").run.run(vim.fn.getcwd()) end, desc = "Run all tests" },
        { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle summary" },
        { "<leader>to", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
        { "<leader>tw", function() require("neotest").watch.toggle() end, desc = "Watch tests" },
        { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop tests" },
        { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
    },
    opts = function()
        return {
            adapters = {
                require("neotest-go")({
                    experimental = { test_table = true },
                    args = { "-count=1", "-race" },
                }),
            },
            status = { virtual_text = true },
            output = { open_on_run = false },
        }
    end,
}
