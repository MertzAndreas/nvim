require("mini.git").setup()
require("mini.diff").setup({
  view = {
    style = "sign",
    signs = { add = "┃", change = "┃", delete = "┃" },
  },
})

require("diffview").setup({
  keymaps = {
    view = {
      { "n", "<leader>co", require("diffview.actions").conflict_choose("ours") },
      { "n", "<leader>ct", require("diffview.actions").conflict_choose("theirs") },
      { "n", "<leader>cb", require("diffview.actions").conflict_choose("base") },
      { "n", "<leader>cA", require("diffview.actions").conflict_choose("all") },
      { "n", "dx",         require("diffview.actions").conflict_choose("none") },
      { "n", "q",          require("diffview.actions").close,                    { desc = "Close diffview" } },
    },
    file_panel = {
      { { "n", "x" }, "<space>",   false },
      { { "n", "x" }, "<C-Space>", require("diffview.actions").toggle_select_entry },
      { "n",          "<leader>b", require("diffview.actions").toggle_files },
      { "n",          "q",         require("diffview.actions").close,              { desc = "Close diffview" } },
    },
  },
})

vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewToggle<cr>", {
  desc = "Diffview: Toggle",
})

vim.keymap.set("n", "<leader>gF", "<cmd>DiffviewFileHistory<cr>", {
  desc = "Diffview: File history",
})
