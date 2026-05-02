require("nvim-treesitter").setup()
require("nvim-treesitter").install({
    "gitignore",
    "json",
    "python",
    "markdown",
    "rust",
    "javascript",
    "typescript",
    "jsx",
    "c_sharp",
    "tsx",
    "dockerfile",
    "editorconfig",
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Start Treesitter",
    callback = function(args)
        if pcall(vim.treesitter.start, args.buf) then
            return
        end
        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if lang then
            pcall(vim.treesitter.start, args.buf, lang)
        end
    end,
})
