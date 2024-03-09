require("lspconfig").ruff.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

require("lspconfig").bashls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

require("lspconfig").clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

require("lspconfig").yamlls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

require("lspconfig").dockerls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

require("lspconfig").cmake.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

require("lspconfig").nixd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

require("lspconfig").html.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
