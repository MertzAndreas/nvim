local keys = require("utils").keys
-- require("roslyn-kit").setup()
require("nvim-ts-autotag").setup()
require("mini.surround").setup()
require("mini.ai").setup()
require("mini.pairs").setup()
require("typst-preview").setup({})
keys({
    {
        "s",
        function()
            require("flash").jump()
        end,
        desc = "Flash",
        mode = { "n", "x", "o" },
    },
    {
        "S",
        function()
            require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
        mode = { "n", "x", "o" },
    },
})

local harpoon = require "harpoon"
harpoon:setup()

-- Jump directly
for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, function()
        harpoon:list():select(i)
    end, { desc = "Jump Harpoon " .. i })
end

vim.keymap.set("n", "<leader>a", function()
    harpoon:list():add()
end, { desc = "Harpoon file" })

local function open_harpoon_picker()
    local list = harpoon:list()
    local items = {}
    for i, h_item in ipairs(list.items) do
        table.insert(items, {
            idx = i,
            text = h_item.value,
            file = h_item.value,
            harpoon_item = h_item,
        })
    end

    Snacks.picker({
        title = "Harpoon",
        items = items,
        format = "file",
        confirm = function(picker, item)
            picker:close()
            -- Use the stored position to select correctly
            list:select(item.idx)
        end,
        actions = {
            harpoon_remove = function(picker)
                local selected = picker:selected({ fallback = true })
                if not selected or #selected == 0 then
                    return
                end
                for _, sel in ipairs(selected) do
                    list:remove(sel.harpoon_item)
                end
                picker:close()
                vim.schedule(open_harpoon_picker)
            end,
        },
        win = {
            input = {
                keys = {
                    ["<C-d>"] = { "harpoon_remove", mode = { "n", "i" } },
                },
            },
            list = {
                keys = {
                    ["d"] = { "harpoon_remove", mode = { "n" } },
                },
            },
        },
    })
end

vim.keymap.set("n", "<C-e>", open_harpoon_picker, { desc = "Harpoon menu" })
