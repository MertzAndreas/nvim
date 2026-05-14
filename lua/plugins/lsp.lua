require("blink.cmp").setup({
  signature = { enabled = true },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  fuzzy = { implementation = "prefer_rust" },
  appearance = {
    nerd_font_variant = "mono",
    kind_icons = {
      Text = "󰉿",
      Method = "󰊕",
      Function = "󰊕",
      Constructor = "󰒓",
      Field = "󰜢",
      Variable = "󰆦",
      Property = "󰖷",
      Class = "󱡠",
      Interface = "󱡠",
      Struct = "󱡠",
      Module = "󰅩",
      Value = "󰦨",
      Enum = "󰦨",
      EnumMember = "󰦨",
      Keyword = "󰻾",
      Constant = "󰏿",
      Snippet = "󱄽",
      Color = "󰏘",
      File = "󰈔",
      Reference = "󰬲",
      Folder = "󰉋",
      Event = "󱐋",
      Operator = "󰪚",
      TypeParameter = "󰬛",
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
  },
})

vim.lsp.enable({ "rust_analyzer", "lua_ls", "roslyn_ls", "vtsls", "tailwindcss", "clangd", "tinymist", "basedpyright" })
