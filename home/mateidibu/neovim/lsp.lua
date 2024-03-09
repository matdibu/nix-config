vim.diagnostic.config({
    float = { border = "rounded" },
})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "spell" },
        { name = "luasnip" },
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                path = "[Path]",
                spell = "[Spell]",
                luasnip = "[Snip]",
            })[entry.source.name]
            return vim_item
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
    },
})

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

-- lsp's

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").nil_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        ["nil"] = {
            nix = {
                maxMemoryMB = 8192,
                flake = {
                    autoArchive = true,
                    autoEvalInputs = true,
                },
            },
            formatting = {
                command = { "nixpkgs-fmt" },
            },
        },
    },
})

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
