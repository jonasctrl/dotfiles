return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "fredrikaverpil/neotest-golang",
    },
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
                require("neotest-golang")({
                    -- runner = "gotestsum", -- recommended (more reliable JSON parsing);
                    -- requires: go install gotest.tools/gotestsum@latest
                    go_test_args = { "-v", "-count=1", "-race" },
                    warn_test_name_dupes = false,
                }),
            },
            status = { virtual_text = false },
            output = { open_on_run = false },
        }
    end,
}
