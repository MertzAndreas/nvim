vim.pack.add({ { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim", load = false } })
require("render-markdown").setup()
vim.opt_local.wrap = true
vim.opt_local.spell = true
