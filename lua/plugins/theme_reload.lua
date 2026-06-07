local M = {}

local generated = vim.fn.stdpath "config" .. "/lua/plugins/colors.lua"

local function apply_theme()
    local ok, spec = pcall(dofile, generated)
    if not ok or type(spec) ~= "table" then
        vim.notify("theme reload failed: " .. tostring(spec), vim.log.levels.ERROR)
        return
    end
    require("mini.base16").setup({ palette = spec })
end

function M.setup()
    apply_theme()
    if not _G._matugen_watcher then
        _G._matugen_watcher = assert(vim.uv.new_fs_event())
        _G._matugen_watcher:start(
            generated,
            {},
            vim.schedule_wrap(function()
                apply_theme()
                print "Theme reloaded"
            end)
        )
    end
end

return M
