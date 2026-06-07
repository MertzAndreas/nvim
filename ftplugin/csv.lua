vim.pack.add({
    { src = "https://github.com/hat0uma/csvview.nvim" },
})

require("csvview").setup({
    keymaps = {
        -- Text objects for selecting fields
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
    },
})

require("csvview").enable(0, {
    view = {
        display_mode = "border",
        header_lnum = 1,
    },
})
