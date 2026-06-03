local keys = require("utils").keys
require("nvim-ts-autotag").setup()
require("mini.surround").setup()
require("mini.ai").setup()
require("mini.pairs").setup()
require('mini.move').setup()

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
