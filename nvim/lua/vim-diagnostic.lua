vim.diagnostic.config({
    virtual_text = {
        source = "if_many",
        prefix = "",
        severity = { min = vim.diagnostic.severity.WARN },
    },
    signs = false,
    underline = false,
    update_in_insert = false,
    severity_sort = true,
})
