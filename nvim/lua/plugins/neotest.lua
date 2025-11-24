-- NOTE: Helps in running and managing tests.
return {
    "nvim-neotest/neotest",
    enabled = true,
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-go",
    },
    config = function()
        local neotest = require("neotest")

        neotest.setup({
            adapters = {
                require("neotest-go")({
                    experimental = { test_table = true },
                    args = { "-count=1", "-race" },
                }),
            },
        })

        -- Keymaps
        vim.keymap.set("n", "<leader>tt", neotest.run.run, { desc = "Run nearest test" })
        vim.keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end,
            { desc = "Run file tests" })
        vim.keymap.set("n", "<leader>ta", function() neotest.run.run(vim.fn.getcwd()) end,
            { desc = "Run all tests in cwd" })

        vim.keymap.set("n", "<leader>ts", neotest.summary.toggle, { desc = "Toggle summary" })
        vim.keymap.set("n", "<leader>to", neotest.output_panel.toggle, { desc = "Toggle output panel" })

        -- Optional QoL
        vim.keymap.set("n", "<leader>tw", neotest.watch.toggle, { desc = "Watch tests" })
        vim.keymap.set("n", "<leader>tS", neotest.run.stop, { desc = "Stop running tests" })
    end,
}
