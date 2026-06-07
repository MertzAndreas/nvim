require("vim._core.ui2").enable()
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

require("mini.input").setup()
require("mini.notify").setup()

require("mini.indentscope").setup({
  symbol = '│',
  draw = {
    delay = 0,
    animation = require("mini.indentscope").gen_animation.quadratic(
      {
        easing = 'out',
        duration = 100,
        unit = 'total'
      })
  },
  options = {
    indent_at_cursor = false
  }
})

require("mini.files").setup()
local show_dotfiles = true
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    vim.keymap.set("n", "<M-h>", function()
      show_dotfiles = not show_dotfiles
      MiniFiles.refresh({
        content = {
          filter = show_dotfiles
              and function() return true end
              or function(e) return not vim.startswith(e.name, ".") end
        }
      })
    end, { buffer = args.data.buf_id })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "minifiles",
  callback = function()
    vim.keymap.set("n", "<C-e>", function()
      local state = require("mini.files").get_explorer_state()
      local dir = state and state.windows and state.windows[#state.windows].path

      vim.fn.jobstart({ "nautilus", dir }, { detach = true })
    end, { buffer = true })
  end,
})


vim.keymap.set("n", "<leader><tab>", MiniFiles.open, { desc = "File Explorer" })

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
      local location      = '%p%%'
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
