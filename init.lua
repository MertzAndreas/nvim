vim.cmd.packadd "nvim.undotree"

vim.pack.add({
  -- Git
  { src = "https://github.com/dlyongemallo/diffview.nvim" },
  { src = "https://github.com/nvim-mini/mini.diff" },
  { src = "https://github.com/nvim-mini/mini-git" },

  -- Theme
  { src = "https://github.com/RRethy/base16-nvim" },

  -- UI
  { src = "https://github.com/folke/todo-comments.nvim" },
  { src = "https://github.com/folke/snacks.nvim" },
  { src = "https://github.com/hat0uma/csvview.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
  { src = "https://github.com/nvim-mini/mini.icons" },

  -- LSP
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/folke/lazydev.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },

  -- Editing
  { src = "https://github.com/folke/flash.nvim" },
  { src = "https://github.com/saghen/blink.cmp",                         version = vim.version.range "*" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/nvim-mini/mini.surround" },
  { src = "https://github.com/nvim-mini/mini.ai" },
  { src = "https://github.com/nvim-mini/mini.pairs" },
  { src = "https://github.com/folke/persistence.nvim" },

  -- Misc
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

require "options"
require "keymaps"
require "autocmds"
require "plugins.ui"
require "plugins.editing"
require "plugins.git"
require "plugins.lsp"
require "plugins.treesitter"
require("plugins.theme_reload").setup()
