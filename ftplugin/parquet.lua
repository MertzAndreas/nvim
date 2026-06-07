local buf = vim.api.nvim_get_current_buf()
local parquet_path = vim.api.nvim_buf_get_name(buf)
local tmp_csv = "/tmp/nvim_parquet_" .. buf .. ".csv"

local csv_cmd = string.format(
  "COPY (SELECT * FROM read_parquet('%s')) TO '%s' (FORMAT CSV, HEADER TRUE)",
  parquet_path,
  tmp_csv
)

vim.system(
  { "duckdb", "-c", csv_cmd },
  {},
  function(out)
    if out.code ~= 0 then
      vim.schedule(function()
        vim.notify("DuckDB conversion failed:\n" .. out.stderr, vim.log.levels.ERROR)
      end)
      return
    end
    vim.schedule(function()
      local csv_name = parquet_path:gsub("%.parquet$", ".csv")
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.fn.readfile(tmp_csv))
      vim.api.nvim_buf_set_name(buf, csv_name)
      vim.bo[buf].filetype = "csv"
      vim.bo[buf].modified = false
      vim.bo[buf].modifiable = false
      vim.fn.delete(tmp_csv)
    end)
  end)
