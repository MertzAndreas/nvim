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
require("csvview").setup({
  keymaps = {
    -- Text objects for selecting fields
    textobject_field_inner = { "if", mode = { "o", "x" } },
    textobject_field_outer = { "af", mode = { "o", "x" } },
    jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
    jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
    jump_next_row = { "<Enter>", mode = { "n", "v" } },
    jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
  }
})


vim.api.nvim_create_autocmd("FileType", {
  pattern = "csv",
  callback = function(args)
    require("csvview").enable(args.buf, {
      view = {
        display_mode = "border",
        header_lnum = 1,
      }
    })
  end
})
