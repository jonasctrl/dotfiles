return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        filesystem = {
            filtered_items = {
                visible = true,
                hide_dotfiles = false,
                hide_gitignored = false,
            },
            follow_current_file = { enabled = true },
            use_libuv_file_watcher = true,
        },
        window = {
            width = 35,
            mappings = {
                ["<space>"] = "none",
            },
        },
        popup_border_style = "rounded",
        default_component_configs = {
            indent = {
                with_expanders = true,
            },
            git_status = {
                symbols = {
                    added = "A",
                    modified = "M",
                    deleted = "D",
                    renamed = "R",
                    untracked = "U",
                    ignored = "I",
                    unstaged = "",
                    staged = "S",
                    conflict = "C",
                },
            },
        },
    },
    keys = {
        { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "File Explorer" },
    },
}
