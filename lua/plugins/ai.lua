local keys = require("utils").keys

vim.schedule(function()
    require("copilot").setup()
    require("codecompanion").setup({
        interactions = {
            chat = { adapter = "copilot" },
            inline = { adapter = "copilot" },
            agent = { adapter = "copilot" },
        },
    })
    keys({
        { "<C-a>", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, silent = true },
        { "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, silent = true },
        { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", silent = true },
    })
    vim.cmd [[cab cc CodeCompanion]]
end)
