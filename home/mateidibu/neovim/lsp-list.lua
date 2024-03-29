local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<space>ih", function()
        vim.lsp.inlay_hint.enable(nil, not vim.lsp.inlay_hint.is_enabled())
    end, bufopts)

    -- formatting
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function()
            vim.lsp.buf.format()
        end,
    })
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").nil_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    -- settings = {
    --     ["nil"] = {
    --         -- nix = {
    --         --     maxMemoryMB = 8192,
    --         --     flake = {
    --         --         autoArchive = true,
    --         --         autoEvalInputs = true,
    --         --     },
    --         -- },
    --         formatting = {
    --             command = { "nixfmt" },
    --         },
    --     },
    -- },
})

require("lspconfig").ruff_lsp.setup({
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

-- require("lspconfig").nixd.setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
-- })

require("lspconfig").html.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

require("lspconfig").lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
