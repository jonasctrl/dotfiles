-- Customize the appearance of diagnostics
vim.diagnostic.config({
    virtual_text = {
        source = "if_many",
        prefix = "",
        severity = { min = vim.diagnostic.severity.WARN },
    },
    signs = false,
    -- NOTE: Disable red squiggly underline
    underline = false,
    update_in_insert = false,
    severity_sort = true,
})
