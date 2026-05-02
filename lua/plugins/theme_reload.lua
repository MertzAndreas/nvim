local M = {}

local function reload_theme()
    local generated = vim.fn.stdpath "config" .. "/lua/plugins/dankcolors.lua"
    package.loaded["base16-colorscheme"] = nil

    local ok, spec = pcall(dofile, generated)
    if not ok then
        vim.notify("theme reload failed: " .. spec, vim.log.levels.ERROR)
        return
    end

    local config_fn = spec and spec[1] and spec[1].config
    if type(config_fn) == "function" then
        pcall(config_fn)
    end
end

function M.setup()
    reload_theme()

    if _G._matugen_watcher then
        return
    end

    local uv = vim.uv or vim.loop
    local generated = vim.fn.stdpath "config" .. "/lua/plugins/dankcolors.lua"

    _G._matugen_watcher = uv.new_fs_event()
    _G._matugen_watcher:start(generated, {}, vim.schedule_wrap(reload_theme))
end

return M
