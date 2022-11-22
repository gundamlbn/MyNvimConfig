local M = {}

-- M.general = {
--   n = {
--     [";"] = { ":", "command mode", opts = { nowait = true } },
--   },
-- }

-- more keybinds!
-- Ctrl+q退出
-- map('n', '<C-q>', ':q<CR>')
M.other = {
    n = {
        ["<C-q>"] = {"<cmd> q <CR>", "退出"},

        -- 分屏
        ["sl"] = {"<cmd> set splitright<CR>:vsplit<CR>", "垂直向右"},
        ["sh"] = {"<cmd> set nosplitright<CR>:vsplit<CR>", "垂直向左"},
        ["sj"] = {"<cmd> set splitright<CR>:split<CR>", "水平向下"},
        ["sk"] = {"<cmd> set nosplitright<CR>:split<CR>", "水平向上"},

        -- 在分屏间移动
        ["<C-h>"] = {"<C-w>h", "向左"},
        ["<C-j>"] = {"<C-w>j", "向下"},
        ["<C-k>"] = {"<C-w>k", "向上"},
        ["<C-l>"] = {"<C-w>l", "向右"},

        -- 改变窗口大小
        ["<up>"] = {"<cmd> res +5<CR>", ""},
        ["<down>"] = {"<cmd> res -5<CR>", ""},
        ["<left>"] = {"<cmd> vertical resize-5<CR>", ""},
        ["<right>"] = {"<cmd> vertical resize+5<CR>", ""}
    },

    v = {
        ["Y"] = {[["+y]], "一件复制到系统剪切板"}
    }
}
-- -- 历史修改记录

M.Undotree = {
    n = {
        ["<M-u>"] = {"<cmd> UndotreeToggle<CR>", "打开/关闭历史编辑记录"}
    }
}

M.AsyncTask = {
    n = {
        ["<F8>"] = {"<cmd> AsyncTask mvn clean install<CR>", "mvn install"},
        ["<F9>"] = {"<cmd> AsyncTask mvn clean package<CR>", "mvn package"}
    }
}

M.Vista = {
    n = {
        ["<M-f>"] = {"<cmd> Vista<CR>", "开启/关闭函数列表"}
    }
}

M.Markdown = {
    n = {
        ["<leader>tm"] = {"<cmd> TableModeToggle<CR>", "创建表格"},
        ["<M-r>"] = {"<cmd> MarkdownPreviewToggle<CR>", "markdown一键预览"}
    }
}

M.format = {
    n = {
        ["<leader>fm"] = {function()
            vim.lsp.buf.formatting()
        end, "   lsp formatting"}
    }
}

M.test = {
    plugin = true,
    n = {
        ["<leader>t"] = {function()
            require("neotest").run.run()
        end, "Run the nearest test"},
        ["<leader>T"] = {function()
            require("neotest").run.run(vim.fn.expand("%"))
        end, "Run the current file"}
    }
}

return M
