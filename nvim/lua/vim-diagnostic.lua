-- Customize the appearance of diagnostics
vim.diagnostic.config({
    virtual_text = {
        source = "if_many",
        prefix = "",
        severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN },
    },
    signs = false,
    underline = {
        severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN },
    },
    update_in_insert = false,
    severity_sort = true,
})
