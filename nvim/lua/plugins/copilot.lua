return {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    keys = {
        {
            "<leader>op",
            function()
                local cmd = require("copilot.command")
                if require("copilot.client").is_disabled() then
                    cmd.enable()
                    vim.notify("Copilot ON")
                else
                    cmd.disable()
                    vim.notify("Copilot OFF")
                end
            end,
            desc = "Toggle Copilot",
        },
    },
    config = function(_, opts)
        require("copilot").setup(opts)
        require("copilot.command").disable()
    end,
    opts = {
        suggestion = {
            auto_trigger = true,
            hide_during_completion = false,
            keymap = {
                accept = "<C-l>",
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<C-]>",
            },
        },
        panel = { enabled = false },
        filetypes = {
            ["*"] = true,
            [".env"] = false,
            gitcommit = false,
            gitrebase = false,
            help = false,
        },
    },
}
