local dap = require "dap"
local dapui = require "dapui"

---@diagnostic disable-next-line: missing-fields
dapui.setup({
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.55 },
                { id = "stacks", size = 0.25 },
                { id = "breakpoints", size = 0.20 },
            },
            size = 45,
            position = "left",
        },
    },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
vim.keymap.set("n", "<Leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "Debug: Run Last" })
vim.keymap.set("n", "<Leader>dw", function()
    dapui.float_element("watches", { enter = true })
end, { desc = "Debug: Float Watches" })
vim.keymap.set("n", "<Leader>dc", function()
    dapui.float_element("console", { enter = true })
end, { desc = "Debug: Float Console" })
vim.keymap.set("n", "<Leader>de", dapui.eval, { desc = "Debug: Eval Expression Under Cursor" })

require("dap-python").setup "python3"

require("dap-go").setup({
    delve = { path = "dlv" },
})

vim.g.rustaceanvim = {
    server = {
        on_attach = function(_, bufnr)
            vim.keymap.set("n", "<Leader>dR", function()
                vim.cmd.RustLsp "debuggables"
            end, { desc = "Debug: Rust (rebuild + launch)", buffer = bufnr })
        end,
        default_settings = {
            ["rust-analyzer"] = {
                cargo = { allFeatures = true },
                check = { command = "clippy" },
            },
        },
    },
}

dap.adapters.coreclr = {
    type = "executable",
    command = "netcoredbg",
    args = { "--interpreter=vscode" },
}
dap.configurations.cs = {
    {
        type = "coreclr",
        name = "Launch",
        request = "launch",
        program = function()
            return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end,
    },
}
