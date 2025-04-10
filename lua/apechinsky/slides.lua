local M = {}

M.setup = function (opts)
    opts = opts or {}
end

---@class present.Slides
---@field slide string[]: slides of the file

---Parse the lines into slides
---@param lines string[]: lines of the file
---@return present.Slides
local parse_slides = function(lines)
    local slides = {}
    local slide = nil

    for _, line in ipairs(lines) do
        local is_header = line:find("^## ") or line:find("^== ")

        if is_header then
            if slide ~= nil then
                table.insert(slides, slide)
            end
            slide = {}
        end

        if slide ~= nil then
            table.insert(slide, line)
        end
    end
    table.insert(slides, slide)
    return slides
end

local function create_floating_window(opts)
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)

    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local buf = vim.api.nvim_create_buf(false, true)

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })
    return { buf = buf, win = win }
end

---Start the presentation for current or specified buffer
---@params opts {buf: number}
M.start = function (opts)
    opts = opts or {}
    opts.buf = opts.buf or vim.api.nvim_get_current_buf()

    local lines = vim.api.nvim_buf_get_lines(opts.buf, 0, -1, false)
    local slides = parse_slides(lines)
    local float = create_floating_window()

    vim.api.nvim_buf_set_lines(float.buf, 0, -1, false, slides[1])

    local current_slide = 1

    vim.keymap.set("n", "n", function ()
        current_slide = math.min(current_slide + 1, #slides)
        vim.api.nvim_buf_set_lines(float.buf, 0, -1, false, slides[current_slide])
    end, { buffer = float.buf })

    vim.keymap.set("n", "p", function ()
        current_slide = math.max(current_slide - 1, 1)
        vim.api.nvim_buf_set_lines(float.buf, 0, -1, false, slides[current_slide])
    end, { buffer = float.buf })

    vim.keymap.set("n", "q", function ()
        vim.api.nvim_win_close(float.win, true)
    end, { buffer = float.buf })
end

return M
-- parse_slides({ "= h1", "line", "== h2-1", "line1", "== h2-2", "line1", "== h2-3", "line3" })

