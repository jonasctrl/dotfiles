return {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    opts = {
        suggestion = {
            enabled = true,
            auto_trigger = true,
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
            markdown = true,
            yaml = true,
        },
    },
}
