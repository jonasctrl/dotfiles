return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "leoluz/nvim-dap-go",
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },
    keys = {
        { "<F5>", function() require("dap").continue() end, desc = "Debug: continue" },
        { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Debug: toggle breakpoint" },
        { "<F10>", function() require("dap").step_over() end, desc = "Debug: step over" },
        { "<leader>du", function() require("dapui").toggle() end, desc = "Debug: toggle UI" },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        require("dap-go").setup()
        dapui.setup({
            layouts = {
                {
                    elements = {
                        { id = "scopes", size = 0.6 },
                        { id = "breakpoints", size = 0.4 },
                    },
                    size = 40,
                    position = "left",
                },
            },
        })

        dap.configurations.go = vim.list_extend(dap.configurations.go, {
            {
                type = "delve",
                name = "Attach",
                mode = "local",
                request = "attach",
                processId = function() return require("dap.utils").pick_process({ filter = "go" }) end,
            },
        })
    end,
}
