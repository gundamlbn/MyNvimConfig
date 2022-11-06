vim.lsp.set_log_level("warn")

-- 设置屏幕中间竖条
vim.o.colorcolumn = "120"

-- 不复制到系统剪切板
vim.o.clipboard = ""

-- CRLF模式保存
vim.o.fileformats = "dos,unix"

-- 禁用多光标警告
vim.g.VM_show_warnings = 0

-- 设置asynctasks窗口排版
vim.g.asynctasks_term_pos = 'bottom'
vim.g.asynctasks_term_rows = 15

-- vim-table-mode更改为markdown语法
vim.g.table_mode_corner = '|'

-- 打开时自动定位到上次关闭位置
vim.api.nvim_create_autocmd({"BufReadPost"}, {
    pattern = "*",
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]
})

local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
    pattern = "java",
    callback = function()
        vim.opt.shiftwidth = 4
        vim.opt.tabstop = 4
        vim.opt.softtabstop = 4
    end
})

vim.cmd "au! BufRead,BufEnter *.class set filetype=java"
-- -- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
