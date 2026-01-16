return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "leoluz/nvim-dap-go",
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },
    config = function()
        require("dap-go").setup()

        require("dapui").setup({
            layouts = {
                {
                    elements = {
                        {
                            id = "scopes",
                            size = 0.6,
                        },
                        {
                            id = "breakpoints",
                            size = 0.4,
                        },
                    },
                    size = 40,
                    position = "left",
                },
            },
        })

        require("dap").configurations.go = vim.list_extend(require("dap").configurations.go, {
            {
                type = "delve",
                name = "Attach",
                mode = "local",
                request = "attach",
                processId = function()
                    return require("dap.utils").pick_process({ filter = "go" })
                end,
            }
        })
    end,
    keys = {
        { "<F5>",       function() require("dap").continue() end },
        { "<F9>",       function() require("dap").toggle_breakpoint() end },
        { "<F10>",      function() require("dap").step_over() end },
        { "<leader>du", function() require("dapui").toggle() end,         desc = "Toggle DAP UI" },
    }
}
