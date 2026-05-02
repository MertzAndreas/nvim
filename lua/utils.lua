-- lua/utils.lua
local M = {}

---@class KeyMap
---@field [1] string lhs
---@field [2] string|function rhs
---@field desc? string
---@field mode? string|string[]
---@field expr? boolean
---@field silent? boolean
---@field remap? boolean

---@param mappings KeyMap[]
function M.keys(mappings)
  for _, m in ipairs(mappings) do
    vim.keymap.set(m.mode or "n", m[1], m[2], {
      desc = m.desc,
      expr = m.expr,
      silent = m.silent,
      remap = m.remap,
    })
  end
end

return M
