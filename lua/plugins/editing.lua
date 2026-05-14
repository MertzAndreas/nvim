local keys = require("utils").keys
-- require("roslyn-kit").setup()
require("nvim-ts-autotag").setup()
require("mini.surround").setup()
require("mini.ai").setup()
require("mini.pairs").setup()
require("typst-preview").setup({
  -- Hack for dms.
  open_cmd = 'dms open %s > /dev/null 2>&1',
})
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

vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = "*.parquet",
  callback = function(args)
    local parquet_path = vim.fn.expand("<afile>:p")
    local tmp_csv = "/tmp/nvim_parquet_" .. vim.fn.getpid() .. ".csv"

    local cmd = string.format(
      "duckdb -c \"COPY (SELECT * FROM read_parquet('%s')) TO '%s' (FORMAT CSV, HEADER TRUE)\"",
      parquet_path,
      tmp_csv
    )

    local result = vim.fn.system(cmd)
    if vim.v.shell_error ~= 0 then
      vim.notify("DuckDB conversion failed:\n" .. result, vim.log.levels.ERROR)
      return
    end

    vim.cmd("silent! read " .. tmp_csv)
    vim.cmd("1delete _")

    local csv_name = parquet_path:gsub("%.parquet$", ".csv")
    vim.api.nvim_buf_set_name(args.buf, csv_name)
    vim.bo[args.buf].filetype = "csv"
    vim.bo[args.buf].buftype = ""
    vim.bo[args.buf].modified = false

    vim.fn.delete(tmp_csv)
  end,
})
