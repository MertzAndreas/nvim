local M = {}

local watcher
local spec_file = vim.fn.stdpath "config" .. "/lua/plugins/colors.lua"

local function blend(fg, bg, alpha)
    local function hex_to_rgb(hex)
        hex = hex:gsub("#", "")
        return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
    end

    local fr, fg_g, fb = hex_to_rgb(fg)
    local br, bg_g, bb = hex_to_rgb(bg)

    return string.format(
        "#%02x%02x%02x",
        math.floor(fr * alpha + br * (1 - alpha)),
        math.floor(fg_g * alpha + bg_g * (1 - alpha)),
        math.floor(fb * alpha + bb * (1 - alpha))
    )
end

local function apply_diff_highlights(spec)
    local bg = spec.base00
    local alpha = 0.15

    local colors = {
        add = blend(spec.base0B, bg, alpha),
        change = blend(spec.base0D, bg, alpha),
        delete = blend(spec.base08, bg, alpha),
        text = blend(spec.base0D, bg, alpha * 1.4),
    }

    local highlights = {
        DiffAdd = { bg = colors.add },
        DiffChange = { bg = colors.change },
        DiffDelete = { fg = spec.base03, bold = true },
        DiffText = { bg = colors.text },

        DiffviewDiffAddInline = { bg = colors.add },
        DiffviewDiffDeleteInline = { bg = colors.delete },
        DiffviewDiffTextInline = { bg = colors.text },
        DiffviewDiffAddAsDelete = { bg = colors.delete },

        WinSeparator = { fg = spec.base02 },

        FloatBorder = { fg = spec.base02 },
        FloatTitle = { fg = spec.base03 },
        BlinkCmpMenuBorder = { fg = spec.base02 },
        BlinkCmpDocBorder = { fg = spec.base02 },
        BlinkCmpSignatureHelpBorder = { fg = spec.base02 },
    }

    for group, opts in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, opts)
    end
end

local function apply_theme()
    local ok, spec = pcall(dofile, spec_file)
    if not ok or type(spec) ~= "table" then
        vim.notify("Theme reload failed: " .. tostring(spec), vim.log.levels.ERROR)
        return
    end

    require("mini.base16").setup({
        palette = spec,
    })

    apply_diff_highlights(spec)
end

function M.setup()
    apply_theme()

    if watcher then
        return
    end

    watcher = assert(vim.uv.new_fs_event())
    watcher:start(
        spec_file,
        {},
        vim.schedule_wrap(function()
            apply_theme()
            vim.notify "Theme reloaded"
        end)
    )
end

return M
