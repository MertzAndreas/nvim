local keys = require("utils").keys
require("nvim-ts-autotag").setup()
require("mini.surround").setup()
require("mini.ai").setup()
require("mini.pairs").setup()
require('mini.move').setup()

keys({
  {
    "s",
    function()
      require("flash").jump()
    end,
    desc = "Flash",
    mode = { "n", "x", "o" },
  },
  {
    "S",
    function()
      require("flash").treesitter()
    end,
    desc = "Flash Treesitter",
    mode = { "n", "x", "o" },
  },
})
