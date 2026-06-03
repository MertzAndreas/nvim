local keys = require("utils").keys

keys({
  {
    "<leader>R",
    function()
      local session = vim.fn.stdpath "state" .. "/restart_session.vim"
      vim.cmd("mksession! " .. vim.fn.fnameescape(session))
      vim.cmd("restart source " .. vim.fn.fnameescape(session))
    end,
    desc = "Restart Neovim",
  },
  {
    "<leader>h",
    "<cmd>nohlsearch<cr>",
    desc = "Clear selection"
  },
  -- Motion
  {
    "j",
    "v:count == 0 ? 'gj' : 'j'",
    desc = "Down",
    mode = { "n", "x" },
    expr = true,
    silent = true,
  },
  {
    "k",
    "v:count == 0 ? 'gk' : 'k'",
    desc = "Up",
    mode = { "n", "x" },
    expr = true,
    silent = true,
  },
  {
    "H",
    "^",
    desc = "Start of line",
    mode = { "n", "v" },
  },
  {
    "L",
    "g_",
    desc = "End of code on line",
    mode = { "n", "v" },
  },

  -- Windows
  {
    "<C-h>",
    "<C-w>h",
    desc = "Go to Left Window",
    remap = true,
  },
  {
    "<C-j>",
    "<C-w>j",
    desc = "Go to Lower Window",
    remap = true,
  },
  {
    "<C-k>",
    "<C-w>k",
    desc = "Go to Upper Window",
    remap = true,
  },
  {
    "<C-l>",
    "<C-w>l",
    desc = "Go to Right Window",
    remap = true,
  },
  { "<C-Left>",  "5<C-w><" },
  { "<C-Right>", "5<C-w>>" },

  -- Quit
  { "<leader>q", "<cmd>qa<cr>",                    desc = "Quit All" },
  { "<leader>Q", "<cmd>qa<cr>",                    desc = "Quit All" },

  { "<leader>S", "<cmd>lua vim.pack.update()<cr>", desc = "Package Sync" },
  { "<leader>U", ":Undotree<cr>",                  desc = "Undotree" },
})
