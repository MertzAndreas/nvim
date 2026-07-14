vim.cmd.packadd "nvim.undotree"

vim.pack.add({
    -- Git
    { src = "https://github.com/dlyongemallo/diffview.nvim", load = false },

    -- LSP
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/folke/lazydev.nvim" },
    { src = "https://github.com/stevearc/conform.nvim" },

    -- Editing
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range "*" },
    { src = "https://github.com/windwp/nvim-ts-autotag" },

    -- Misc
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
})
require "options"
require "keymaps"
require "autocmds"
require "filetypes"
require "plugins.ui"
require "plugins.editing"
require "plugins.git"
require "plugins.lsp"
require "plugins.treesitter"
require("plugins.theme_reload").setup()
