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

    -- Debug
    { src = "https://github.com/mfussenegger/nvim-dap" },
    { src = "https://github.com/rcarriga/nvim-dap-ui" },
    { src = "https://github.com/nvim-neotest/nvim-nio" },
    { src = "https://github.com/mfussenegger/nvim-dap-python" },
    { src = "https://github.com/leoluz/nvim-dap-go" },
    { src = "https://github.com/mrcjkb/rustaceanvim" },

    -- Testing
    { src = "https://github.com/nvim-neotest/neotest" },
    { src = "https://github.com/nvim-neotest/neotest-python" },
    { src = "https://github.com/fredrikaverpil/neotest-golang" },
    { src = "https://github.com/Nsidorenco/neotest-vstest" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
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
require "plugins.debug"
require "plugins.testing"
require("plugins.theme_reload").setup()
