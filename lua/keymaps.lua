local map = vim.keymap.set

-- Restart Neovim
map("n", "<leader>R", function()
    local session = vim.fn.stdpath "state" .. "/restart_session.vim"
    vim.cmd("mksession! " .. vim.fn.fnameescape(session))
    vim.cmd("restart source " .. vim.fn.fnameescape(session))
end, { desc = "Restart Neovim" })

-- Clear search highlight
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear selection" })

-- Motion: better j/k (screen lines)
map({ "n", "x" }, "j", function()
    return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down" })

map({ "n", "x" }, "k", function()
    return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up" })

map({ "n", "v" }, "H", "^", { desc = "Start of line" })
map({ "n", "v" }, "L", "g_", { desc = "End of code on line" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

map("n", "<C-Left>", "5<C-w><", { desc = "Decrease window width" })
map("n", "<C-Right>", "5<C-w>>", { desc = "Increase window width" })

-- Quit
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit All" })
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit All" })

-- Plugins / commands
map("n", "<leader>S", "<cmd>lua vim.pack.update()<cr>", { desc = "Package Sync" })
map("n", "<leader>U", "<cmd>Undotree<cr>", { desc = "Undotree" })
