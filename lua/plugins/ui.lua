require("vim._core.ui2").enable()
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    -- Leader
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },

    -- Built-in prefixes
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },

    -- Marks & registers
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'n', keys = '"' },

    -- window management
    { mode = 'n', keys = '<C-w>' },

    -- Insert/command mode registers
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },
  },
  clues = {
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.z(),
    miniclue.gen_clues.windows(), -- for <C-w>
  },
  window = {
    config = { width = "auto", anchor = "SE", row = 'auto', col = 'auto' },

    delay = 300,
  },

})


vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
})

require "mini.statusline".setup({
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local git           = MiniStatusline.section_git({ trunc_width = 40 })
      local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
      local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
      local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
      local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local location      = MiniStatusline.section_location({ trunc_width = 75 })
      local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })

      return MiniStatusline.combine_groups({
        { hl = mode_hl,                 strings = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
        '%<', -- Mark general truncate point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=', -- End left alignment
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl,                  strings = { search, location } },
      })
    end
  }
})
require "plugins.snacks"
