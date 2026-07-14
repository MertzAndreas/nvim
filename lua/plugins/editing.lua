require("nvim-ts-autotag").setup()
require("mini.surround").setup()
require("mini.ai").setup()
require("mini.pairs").setup()
require("mini.move").setup()
require("mini.jump2d").setup()

local fzf = require "fzf-lua"

fzf.setup({
    fzf_colors = {
        true,
    },
    winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        border = "solid",
        title_pos = "center",
        preview = {
            layout = "vertical",
            vertical = "right:55%",
            border = "solid",
            title = true,
            title_pos = "center",
        },
    },
    files = {
        fd_opts = [[--color=never --type f --hidden --follow --exclude .git]],
    },
    grep = {
        rg_opts = [[--column --line-number --no-heading --color=always --smart-case --hidden -g '!.git']],
    },
})

local map = vim.keymap.set

map("n", "<leader><space>", function()
    fzf.files()
end, { desc = "Find Files" })
map("n", "<leader>ff", function()
    fzf.files()
end, { desc = "Find Files" })

map("n", "<leader>fc", function()
    fzf.files({
        cwd = vim.fn.stdpath "config",
    })
end, { desc = "Find Config File" })

map("n", "<leader>fg", function()
    fzf.git_files()
end, { desc = "Git Files" })

map("n", "<leader>fr", function()
    fzf.oldfiles()
end, { desc = "Recent Files" })

map("n", "<leader>sg", function()
    fzf.live_grep()
end, { desc = "Grep" })

map("n", "<leader>sr", function()
    fzf.resume()
end, { desc = "Resume Picker" })

map("n", "<leader>sb", function()
    fzf.blines()
end, { desc = "Buffer Lines" })

map("n", "<leader>:", function()
    fzf.command_history()
end, { desc = "Command History" })

map("n", "<leader>s/", function()
    fzf.search_history()
end, { desc = "Search History" })

map("n", "<leader>sq", function()
    fzf.quickfix()
end, { desc = "Quickfix List" })

map("n", "<leader>sm", function()
    fzf.marks()
end, { desc = "Marks" })

map("n", "<leader>sj", function()
    fzf.jumps()
end, { desc = "Jumps" })

map("n", '<leader>s"', function()
    fzf.registers()
end, { desc = "Registers" })

map("n", "grd", function()
    fzf.lsp_definitions()
end, { desc = "Goto Definition" })

map("n", "grD", function()
    fzf.lsp_declarations()
end, { desc = "Goto Declaration" })

map("n", "grr", function()
    fzf.lsp_references()
end, { desc = "References" })

map("n", "gri", function()
    fzf.lsp_implementations()
end, { desc = "Implementation" })

map("n", "gy", function()
    fzf.lsp_typedefs()
end, { desc = "Type Definition" })

map("n", "<leader>ss", function()
    fzf.lsp_document_symbols()
end, { desc = "Document Symbols" })

map("n", "<leader>sS", function()
    fzf.lsp_workspace_symbols()
end, { desc = "Workspace Symbols" })

map("n", "<leader>sd", function()
    fzf.diagnostics_document()
end, { desc = "Diagnostics" })

map("n", "<leader>sD", function()
    fzf.diagnostics_workspace()
end, { desc = "Workspace Diagnostics" })

map("n", "<leader>gb", function()
    fzf.git_branches()
end, { desc = "Git Branches" })

map("n", "<leader>sh", function()
    fzf.highlights()
end, { desc = "Highlights" })

map("n", "<leader>si", function()
    fzf.colorschemes()
end, { desc = "Colorschemes" })

map("n", "<leader>sk", function()
    fzf.keymaps()
end, { desc = "Keymaps" })

map("n", "<leader>sa", function()
    fzf.autocmds()
end, { desc = "Autocmds" })

map("n", "<leader>sC", function()
    fzf.commands()
end, { desc = "Commands" })
