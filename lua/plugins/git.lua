local keys = require("utils").keys
local actions = require "diffview.actions"

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
            { "n", "<leader>co", actions.conflict_choose "ours" },
            { "n", "<leader>ct", actions.conflict_choose "theirs" },
            { "n", "<leader>cb", actions.conflict_choose "base" },
            { "n", "<leader>cA", actions.conflict_choose "all" },
            { "n", "dx", actions.conflict_choose "none" },
            { "n", "q", actions.close, { desc = "Close diffview" } },
        },
        file_panel = {
            { { "n", "x" }, "<space>", false },
            { { "n", "x" }, "<C-Space>", actions.toggle_select_entry },
            { "n", "<leader>b", actions.toggle_files },
            { "n", "q", actions.close, { desc = "Close diffview" } },
        },
    },
})

keys({
    {
        "<leader>gd",
        "<cmd>DiffviewToggle<cr>",
        desc = "Diffview: Toggle",
    },
    {
        "<leader>gF",
        "<cmd>DiffviewFileHistory<cr>",
        desc = "Diffview: File history",
    },
    {
        "<leader>gD",
        function()
            require("snacks").picker.git_log({
                confirm = function(picker, item)
                    picker:close()
                    if item then
                        require("diffview").open(item.commit .. "^!")
                    end
                end,
            })
        end,
        desc = "Diffview: Pick commit to diff",
    },
})
