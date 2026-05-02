local dashboard_header = [[
         *     ,MMM8&&&.            *     
              MMMM88&&&&&    .            
             MMMM88&&&&&&&                
 *           MMM88&&&&&&&&                
             MMM88&&&&&&&&                
             'MMM88&&&&&&'                
               'MMM8&&&'      *           
      |\___/|                             
      )     (             .               
     =\     /=                            
       )===(       *                      
      /     \                             
      |     |                             
     /       \                            
     \       /                            
_/\_/\_/\__  _/_/\_/\_/\_/\_/\_/\_/\_     
|  |  |  |( (  |  |  |  |  |  |  |  |     
|  |  |  | ) ) |  |  |  |  |  |  |  |     
|  |  |  |(_(  |  |  |  |  |  |  |  |     
]]

require("snacks").setup({
    bigfile = { enabled = true },
    dashboard = {
        enabled = true,
        sections = {
            {
                align = "center",
                header = dashboard_header,
            },
            { section = "keys", gap = 1, padding = 1 },
            {
                pane = 2,
                icon = " ",
                desc = "Browse Repo",
                padding = 1,
                key = "b",
                enabled = function()
                    return Snacks.git.get_root() ~= nil
                end,
                action = function()
                    Snacks.gitbrowse()
                end,
            },
            { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
            {
                enabled = function()
                    return Snacks.git.get_root() ~= nil
                end,
                pane = 2,
                icon = " ",
                title = "Open PRs",
                cmd = "gh pr list -L 3",
                key = "P",
                action = function()
                    vim.fn.jobstart("gh pr list --web", { detach = true })
                end,
                height = 3,
            },
        },
    },
    explorer = {
        enabled = true,
        trash = true,
    },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
        enabled = true,
        timeout = 3000,
    },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
        notification = {},
    },
})

-- Top Pickers & Explorer
vim.keymap.set("n", "<leader><space>", function()
    Snacks.picker.files()
end, { desc = "Find Files" })

vim.keymap.set("n", "<leader>,", function()
    Snacks.picker.buffers()
end, { desc = "Buffers" })

vim.keymap.set("n", "<leader>/", function()
    Snacks.picker.grep()
end, { desc = "Grep" })

vim.keymap.set("n", "<leader>:", function()
    Snacks.picker.command_history()
end, { desc = "Command History" })

vim.keymap.set("n", "<leader>n", function()
    Snacks.picker.notifications()
end, { desc = "Notification History" })

vim.keymap.set("n", "<leader><tab>", function()
    Snacks.explorer({
        layout = { layout = { position = "right" } },
        actions = {
            open_file_manager = function(picker)
                local item = picker:current()
                if item then
                    local path = vim.fs.dirname(item.file)
                    vim.fn.jobstart({ "setsid", "nautilus", path }, { detach = true })
                    vim.notify("Opening: " .. path)
                end
                vim.notify "Failed to open file manager"
            end,
        },
        win = {
            list = {
                keys = {
                    ["<C-e>"] = { "open_file_manager", mode = { "n", "i" } },
                },
            },
        },
    })
end, { desc = "File Explorer" })

-- Find
vim.keymap.set("n", "<leader>fb", function()
    Snacks.picker.buffers()
end, { desc = "Buffers" })

vim.keymap.set("n", "<leader>fc", function()
    Snacks.picker.files({ cwd = vim.fn.stdpath "config" })
end, { desc = "Find Config File" })

vim.keymap.set("n", "<leader>ff", function()
    Snacks.picker.files()
end, { desc = "Find Files" })

vim.keymap.set("n", "<leader>fg", function()
    Snacks.picker.git_files()
end, { desc = "Find Git Files" })

vim.keymap.set("n", "<leader>fp", function()
    Snacks.picker.projects()
end, { desc = "Projects" })

vim.keymap.set("n", "<leader>fr", function()
    Snacks.picker.recent()
end, { desc = "Recent" })

-- Git
vim.keymap.set("n", "<leader>gb", function()
    Snacks.picker.git_branches({
        actions = {
            delete_branch = function(picker)
                local items = picker:selected({ fallback = false })
                for _, item in ipairs(items) do
                    vim.fn.system({ "git", "branch", "-D", item.branch })
                end
                picker:refresh()
            end,
        },
        win = {
            input = {
                keys = {
                    ["<C-d>"] = { "delete_branch", mode = { "n", "i" } },
                },
            },
        },
    })
end, { desc = "Git Branches" })

vim.keymap.set("n", "<leader>gl", function()
    Snacks.picker.git_log()
end, { desc = "Git Log" })

vim.keymap.set("n", "<leader>gs", function()
    Snacks.picker.git_status()
end, { desc = "Git Status" })

vim.keymap.set("n", "<leader>gS", function()
    Snacks.picker.git_stash()
end, { desc = "Git Stash" })

vim.keymap.set("n", "<leader>gf", function()
    Snacks.picker.git_log_file()
end, { desc = "Git Log File" })

-- GitHub
vim.keymap.set("n", "<leader>gi", function()
    Snacks.picker.gh_issue()
end, { desc = "GitHub Issues (open)" })

vim.keymap.set("n", "<leader>gI", function()
    Snacks.picker.gh_issue({ state = "all" })
end, { desc = "GitHub Issues (all)" })

vim.keymap.set("n", "<leader>gp", function()
    Snacks.picker.gh_pr()
end, { desc = "GitHub Pull Requests (open)" })

vim.keymap.set("n", "<leader>gP", function()
    Snacks.picker.gh_pr({ state = "all" })
end, { desc = "GitHub Pull Requests (all)" })

-- Grep
vim.keymap.set("n", "<leader>sb", function()
    Snacks.picker.lines()
end, { desc = "Buffer Lines" })

vim.keymap.set("n", "<leader>sB", function()
    Snacks.picker.grep_buffers()
end, { desc = "Grep Open Buffers" })

vim.keymap.set("n", "<leader>sg", function()
    Snacks.picker.grep()
end, { desc = "Grep" })

vim.keymap.set({ "n", "x" }, "<leader>sw", function()
    Snacks.picker.grep_word()
end, { desc = "Visual selection or word" })

-- Search
vim.keymap.set("n", '<leader>s"', function()
    Snacks.picker.registers()
end, { desc = "Registers" })

vim.keymap.set("n", "<leader>s/", function()
    Snacks.picker.search_history()
end, { desc = "Search History" })

vim.keymap.set("n", "<leader>sa", function()
    Snacks.picker.autocmds()
end, { desc = "Autocmds" })

vim.keymap.set("n", "<leader>sc", function()
    Snacks.picker.command_history()
end, { desc = "Command History" })

vim.keymap.set("n", "<leader>sC", function()
    Snacks.picker.commands()
end, { desc = "Commands" })

vim.keymap.set("n", "<leader>sd", function()
    Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })

vim.keymap.set("n", "<leader>sD", function()
    Snacks.picker.diagnostics_buffer()
end, { desc = "Buffer Diagnostics" })

vim.keymap.set("n", "<leader>sH", function()
    Snacks.picker.help()
end, { desc = "Help Pages" })

vim.keymap.set("n", "<leader>st", function()
    Snacks.picker.highlights()
end, { desc = "Search Theme highlights" })

vim.keymap.set("n", "<leader>si", function()
    Snacks.picker.icons()
end, { desc = "Icons" })

vim.keymap.set("n", "<leader>sj", function()
    Snacks.picker.jumps()
end, { desc = "Jumps" })

vim.keymap.set("n", "<leader>sk", function()
    Snacks.picker.keymaps()
end, { desc = "Keymaps" })

vim.keymap.set("n", "<leader>sl", function()
    Snacks.picker.loclist()
end, { desc = "Location List" })

vim.keymap.set("n", "<leader>sm", function()
    Snacks.picker.marks()
end, { desc = "Marks" })

vim.keymap.set("n", "<leader>sM", function()
    Snacks.picker.man()
end, { desc = "Man Pages" })

vim.keymap.set("n", "<leader>sp", function()
    Snacks.picker.lazy()
end, { desc = "Search for Plugin Spec" })

vim.keymap.set("n", "<leader>sq", function()
    Snacks.picker.qflist()
end, { desc = "Quickfix List" })

vim.keymap.set("n", "<leader>sR", function()
    Snacks.picker.resume()
end, { desc = "Resume" })

vim.keymap.set("n", "<leader>su", function()
    Snacks.picker.undo()
end, { desc = "Undo History" })

vim.keymap.set("n", "<leader>uC", function()
    Snacks.picker.colorschemes()
end, { desc = "Colorschemes" })

-- LSP
vim.keymap.set("n", "grd", function()
    Snacks.picker.lsp_definitions()
end, { desc = "Goto Definition" })

vim.keymap.set("n", "grD", function()
    Snacks.picker.lsp_declarations()
end, { desc = "Goto Declaration" })

vim.keymap.set("n", "grr", function()
    Snacks.picker.lsp_references()
end, { nowait = true, desc = "References" })

vim.keymap.set("n", "gri", function()
    Snacks.picker.lsp_implementations()
end, { desc = "Goto Implementation" })

vim.keymap.set("n", "gra", function()
    vim.lsp.buf.code_action()
end)

vim.keymap.set("n", "grn", function()
    vim.lsp.buf.rename()
end)

vim.keymap.set("n", "gy", function()
    Snacks.picker.lsp_type_definitions()
end, { desc = "Goto T[y]pe Definition" })

vim.keymap.set("n", "gai", function()
    Snacks.picker.lsp_incoming_calls()
end, { desc = "C[a]lls Incoming" })

vim.keymap.set("n", "gao", function()
    Snacks.picker.lsp_outgoing_calls()
end, { desc = "C[a]lls Outgoing" })

vim.keymap.set("n", "<leader>ss", function()
    Snacks.picker.lsp_symbols()
end, { desc = "LSP Symbols" })

vim.keymap.set("n", "<leader>sS", function()
    Snacks.picker.lsp_workspace_symbols()
end, { desc = "LSP Workspace Symbols" })

-- Other
vim.keymap.set("n", "<leader>bd", function()
    Snacks.bufdelete()
end, { desc = "Delete Buffer" })

vim.keymap.set("n", "<leader>cR", function()
    Snacks.rename.rename_file()
end, { desc = "Rename File" })

vim.keymap.set({ "n", "v" }, "<leader>gB", function()
    Snacks.gitbrowse()
end, { desc = "Git Browse" })

vim.keymap.set("n", "<leader>gg", function()
    Snacks.lazygit()
end, { desc = "Lazygit" })

vim.keymap.set("n", "<leader>un", function()
    Snacks.notifier.hide()
end, { desc = "Dismiss All Notifications" })

vim.keymap.set({ "n", "i", "t", "v" }, "<C-´>", function()
    Snacks.terminal()
end, { desc = "Toggle Terminal" })

vim.keymap.set({ "n", "t" }, "]]", function()
    Snacks.words.jump(vim.v.count1)
end, { desc = "Next Reference" })

vim.keymap.set({ "n", "t" }, "[[", function()
    Snacks.words.jump(-vim.v.count1)
end, { desc = "Prev Reference" })

vim.api.nvim_create_autocmd("UIEnter", {
    once = true,
    callback = function()
        Snacks.toggle.option("spell", { name = "Spelling" }):map "<leader>us"
        Snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>uw"
        Snacks.toggle.diagnostics():map "<leader>ud"
        Snacks.toggle.treesitter():map "<leader>uT"
        Snacks.toggle.inlay_hints():map "<leader>uh"
        Snacks.toggle.indent():map "<leader>ug"
    end,
})
