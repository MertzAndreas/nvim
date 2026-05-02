vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local socket = os.getenv "KITTY_LISTEN_ON"
        vim.fn.system("kitty @ --to " .. socket .. " set-spacing padding=0")
    end,
})

vim.api.nvim_create_autocmd("VimLeave", {
    callback = function()
        local socket = os.getenv "KITTY_LISTEN_ON"
        vim.fn.system("kitty @ --to " .. socket .. " set-spacing padding=10")
    end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd "tabdo wincmd ="
        vim.cmd("tabnext " .. current_tab)
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    callback = function()
        (vim.hl or vim.highlight).on_yank()
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    desc = "Open at last cursor position",
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
            return
        end
        vim.b[buf].lazyvim_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Easy close with q",
    pattern = {
        "checkhealth",
        "gitsigns-blame",
        "help",
        "lspinfo",
        "notify",
        "qf",
        "git",
        "nvim-undotree",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set("n", "q", function()
                vim.cmd "close"
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
                buffer = event.buf,
                silent = true,
                desc = "Quit buffer",
            })
        end)
    end,
})
