require("blink.cmp").setup({
    signature = { enabled = true },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust" },
    appearance = {
        nerd_font_variant = "mono",
    },
    completion = {
        documentation = {
            auto_show = true,
        },
        menu = {
            draw = {
                padding = 2,
                gap = 2,
                columns = {
                    { "label", "label_description" },
                    { "kind_icon" },
                    { "kind", gap = 3 },
                },
            },
        },
    },
})

vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
})

require("lazydev").setup()
require("conform").setup({
    format_on_save = {
        lsp_format = "fallback",
    },
    formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt" },
    },
})

vim.lsp.enable({
    "rust_analyzer",
    "lua_ls",
    "nixd",
    "roslyn_ls",
    "vtsls",
    "tailwindcss",
    "clangd",
    "tinymist",
    "basedpyright",
    "bashls",
})
