---@diagnostic disable-next-line: missing-fields
require("neotest").setup({
    adapters = {
        require "neotest-python",
        require "neotest-golang",
        require "rustaceanvim.neotest",
        require "neotest-vstest",
    },
})

vim.keymap.set("n", "<Leader>tt", function()
    require("neotest").run.run()
end, { desc = "Test: Run Nearest" })
vim.keymap.set("n", "<Leader>tf", function()
    require("neotest").run.run(vim.fn.expand "%")
end, { desc = "Test: Run File" })
vim.keymap.set("n", "<Leader>td", function()
    require("neotest").run.run({ strategy = "dap" })
end, { desc = "Test: Debug Nearest" })
vim.keymap.set("n", "<Leader>ts", function()
    require("neotest").summary.toggle()
end, { desc = "Test: Summary" })
vim.keymap.set("n", "<Leader>to", function()
    require("neotest").output.open({ enter = true })
end, { desc = "Test: Output" })
vim.keymap.set("n", "<Leader>tw", function()
    require("neotest").watch.toggle(vim.fn.expand "%")
end, { desc = "Test: Watch File" })
