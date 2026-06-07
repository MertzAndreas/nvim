vim.opt_local.wrap = true
vim.opt_local.spell = true

local group = vim.api.nvim_create_augroup("TypstPreview", { clear = true })
local sioyek = nil
local active = false

local function parse_qf(line)
    local file, lnum, col, msg = line:match "([^:]+):(%d+):(%d+):%s*(.*)"
    if file then
        return { filename = file, lnum = tonumber(lnum), col = tonumber(col), text = msg }
    end
    return { text = line }
end

local function sync_pdf(pdf)
    if not sioyek then
        sioyek = vim.system({ "sioyek", pdf }, {}, function()
            sioyek = nil
        end)
    end
end

local function compile()
    local src = vim.api.nvim_buf_get_name(0)
    if src == "" then
        vim.notify("No file", vim.log.levels.WARN)
        return
    end
    local pdf = vim.fn.fnamemodify(src, ":r") .. ".pdf"
    vim.system({ "typst", "compile", src, pdf, "--diagnostic-format", "short" }, { text = true }, function(res)
        vim.schedule(function()
            local qf = {}
            for line in vim.gsplit((res.stdout or "") .. "\n" .. (res.stderr or ""), "\n", { plain = true }) do
                if line ~= "" then
                    table.insert(qf, parse_qf(line))
                end
            end
            vim.fn.setqflist(qf, "r")
            if res.code ~= 0 then
                vim.notify("Typst compile failed", vim.log.levels.ERROR)
                vim.cmd "copen"
            else
                vim.cmd "cclose"
                sync_pdf(pdf)
            end
        end)
    end)
end

local function start()
    if active then
        return
    end
    active = true
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = group,
        pattern = "*.typ",
        callback = compile,
    })
    compile()
    vim.notify "Typst preview started"
end

local function stop()
    if not active then
        return
    end
    active = false
    vim.api.nvim_clear_autocmds({ group = group })
    if sioyek then
        sioyek:kill "sigterm"
        sioyek = nil
    end
    vim.notify "Typst preview stopped"
end

vim.api.nvim_create_user_command("TypstPreview", start, {})
vim.api.nvim_create_user_command("TypstPreviewStop", stop, {})
