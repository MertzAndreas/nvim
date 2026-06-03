local keys = require("utils").keys

keys({
    desc = "Go to end of line",
  },

    -- Windows
    {
        "<C-h>",
        "<C-w>h",
        desc = "Go to Left Window",
        remap = true,
    },
    {
        "<C-j>",
        "<C-w>j",
        desc = "Go to Lower Window",
        remap = true,
    },
    {
        "<C-k>",
        "<C-w>k",
        desc = "Go to Upper Window",
        remap = true,
    },
    {
        "<C-l>",
        "<C-w>l",
        desc = "Go to Right Window",
        remap = true,
    },
    { "<C-Left>", "5<C-w><" },
    { "<C-Right>", "5<C-w>>" },

    -- Move lines
    { "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", desc = "Move Down" },
    { "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", desc = "Move Up" },
    {
        "<A-j>",
        "<esc><cmd>m .+1<cr>==gi",
        desc = "Move Down",
        mode = "i",
    },
    {
        "<A-k>",
        "<esc><cmd>m .-2<cr>==gi",
        desc = "Move Up",
        mode = "i",
    },
    {
        "<A-j>",
        ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv",
        desc = "Move Down",
        mode = "v",
    },
    {
        "<A-k>",
        ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv",
        desc = "Move Up",
        mode = "v",
    },

    -- Indenting
    {
        "<",
        "<gv",
        desc = "Indent keep selection",
        mode = "x",
    },
    {
        ">",
        ">gv",
        desc = "Indent keep selection",
        mode = "x",
    },

    -- Quit
    { "<leader>q", "<cmd>qa<cr>", desc = "Quit All" },
    { "<leader>Q", "<cmd>qa<cr>", desc = "Quit All" },

    { "<leader>S", "<cmd>lua vim.pack.update()<cr>", desc = "Package Sync" },
    { "<leader>U", ":Undotree<cr>", desc = "Undotree" },
})
