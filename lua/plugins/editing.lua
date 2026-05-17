local keys = require("utils").keys
require("nvim-ts-autotag").setup()
require("mini.surround").setup()
require("mini.ai").setup()
require("mini.pairs").setup()

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


require "persistence".setup()
vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end)
vim.keymap.set("n", "<leader>qS", function() require("persistence").select() end)
vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end)
vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end)
