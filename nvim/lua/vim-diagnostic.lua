-- Customize the appearance of diagnostics
vim.diagnostic.config({
    virtual_text = {
        source = "if_many",
        prefix = "",
        severity = { min = vim.diagnostic.severity.WARN },
    },
    signs = false,
    underline = {
        severity = { min = vim.diagnostic.severity.WARN },
    },
    update_in_insert = false,
    severity_sort = true,
})
