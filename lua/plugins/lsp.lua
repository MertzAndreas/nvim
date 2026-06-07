require("blink.cmp").setup({
    signature = { enabled = true },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust" },
    appearance = {
        nerd_font_variant = "mono",
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
    },
})

vim.lsp.enable({
    "rust_analyzer",
    "lua_ls",
    "roslyn_ls",
    "vtsls",
    "tailwindcss",
    "clangd",
    "tinymist",
    "basedpyright",
    "bashls",
})
