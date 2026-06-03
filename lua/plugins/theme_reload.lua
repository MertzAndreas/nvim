local M = {}

local function apply_theme()
  local generated = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"

  local ok, spec = pcall(dofile, generated)
  if not ok then
    vim.notify("theme reload failed: " .. spec, vim.log.levels.ERROR)
    return
  end

  if type(spec) ~= "table" or type(spec) ~= "table" then
    vim.notify("theme reload failed: invalid palette format", vim.log.levels.ERROR)
    return
  end

  local ok_setup, err = pcall(function()
    require("mini.base16").setup({
      palette = spec,
    })
  end)

  if not ok_setup then
    vim.notify("mini.base16 setup failed: " .. err, vim.log.levels.ERROR)
  end
end

function M.setup()
  apply_theme()

  if _G._matugen_watcher then
    return
  end

  local uv = vim.uv or vim.loop
  local generated = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"

  local watcher = uv.new_fs_event()
  _G._matugen_watcher = watcher
  if not watcher then
    vim.notify("fs_event watcher not available", vim.log.levels.ERROR)
    return
  end

  watcher:start(
    generated,
    {},
    vim.schedule_wrap(function()
      apply_theme()
      print("Theme reloaded")
    end)
  )
end

return M
