return {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("gitlinker").setup({})

        vim.keymap.set('n', '<leader>gf', function()
            local file_path = vim.fn.expand('%:.')
            local line_number = vim.fn.line('.')

            local blame_cmd = string.format('git blame -L %d,%d --porcelain "%s"', line_number, line_number, file_path)
            local handle = io.popen(blame_cmd)
            local result = handle:read("*a")
            handle:close()

            local commit_hash = result:match("^([a-f0-9]+)")
            if not commit_hash then return end

            local remote_handle = io.popen("git remote get-url origin")
            local remote_url = remote_handle:read("*a"):gsub("\n", "")
            remote_handle:close()

            local https_url = remote_url
            if https_url:match("^git@") then
                https_url = https_url:gsub("^git@([^:]+):", "https://%1/")
            end
            https_url = https_url:gsub("%.git$", "")

            local commit_url = https_url .. "/commit/" .. commit_hash

            local open_cmd = vim.fn.has("mac") == 1 and "open" or "xdg-open"
            os.execute(string.format('%s "%s"', open_cmd, commit_url))
        end, { desc = "Open commit in browser" })
    end,
}
