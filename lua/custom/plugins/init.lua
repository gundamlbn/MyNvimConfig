local overrides = require "custom.plugins.overrides"

local function close_all_floating_wins()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local config = vim.api.nvim_win_get_config(win)
        if config.relative ~= '' then
            vim.api.nvim_win_close(win, false)
        end
    end
end

local function restore_nvim_tree()
    -- vim.cmd "PackerLoad nvim-lspconfig nvim-jdtls"
    local nvim_tree = require('nvim-tree')
    nvim_tree.change_dir(vim.fn.getcwd())
    nvim_tree.refresh()
end

return {

    -- 平滑滚动
    ["karb94/neoscroll.nvim"] = {
        opt = true,
        config = function()
            require "custom.plugins.configs"
        end,
        keys = {"<A-j>", "<A-k>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb"}
    },

    -- 历史修改记录
    ["mbbill/undotree"] = {
        opt = true,
        cmd = "UndotreeToggle"
    },

    -- 多光标
    ["mg979/vim-visual-multi"] = {
        keys = "<C-n>"
    },

    -- 增删改引号
    ["tpope/vim-surround"] = {
        keys = {"c", "d", "S"}
    },

    -- 快速选中
    ["gcmt/wildfire.vim"] = {
        keys = "<CR>"
    },

    -- 快速分析启动时间
    ["dstein64/vim-startuptime"] = {
        cmd = "StartupTime"
    },

    -- 现代任务系统
    ["skywind3000/asynctasks.vim"] = {
        module = {"telescope"},
        requires = "skywind3000/asyncrun.vim",
        cmd = {"AsyncTask", "AsyncTaskEdit", "Telescope"},
        opt = true
    },

    ["GustavoKatel/telescope-asynctasks.nvim"] = {
        module = {"telescope"},
        requires = {"nvim-lua/popup.nvim"},
        config = function()
            require('telescope').extensions.asynctasks.all()
        end
    },

    -- 函数列表
    ["liuchengxu/vista.vim"] = {
        cmd = "Vista"
    },

    -- markdown预览
    ["iamcco/markdown-preview.nvim"] = {
        run = "cd app && yarn install",
        ft = "markdown"
    },

    -- 制作markdown表格
    ["dhruvasagar/vim-table-mode"] = {
        cmd = "TableModeToggle"
    },

    -- session管理
    ["rmagatti/auto-session"] = {
        config = function()
            require('auto-session').setup {
                log_level = "error",
                -- auto_session_enable_last_session = true,
                auto_save_enabled = true,
                auto_restore_enabled = true,
                bypass_session_save_file_types = {'class'},
                -- cwd_change_handling = {
                --     post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
                --         require("lualine").refresh() -- refresh lualine so the new session name is displayed in the status bar
                --     end
                -- }
                pre_save_cmds = {close_all_floating_wins, "NvimTreeClose"},
                pre_restore_cmds = {restore_nvim_tree}
            }
        end
    },
    ["rmagatti/session-lens"] = {
        after = "telescope.nvim",
        config = function()
            require('session-lens').setup({
                path_display = {'shorten'},
                previewer = true,
                prompt_title = 'YEAH SESSIONS'
            })
        end
    },

    -- AI自动完成

    ["tzachar/cmp-tabnine"] = {
        after = "nvim-cmp",
        run = "powershell ./install.ps1",
        config = function()
            require "custom.plugins.tabnine"
        end
    },

    -- enables dashboard
    -- ["goolord/alpha-nvim"] = {
    --     disable = false
    -- },

    -- Override plugin definition options
    ["neovim/nvim-lspconfig"] = {
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.plugins.lspconfig"
        end
    },

    ["mfussenegger/nvim-jdtls"] = {
        ft = "java"
    },

    -- test
    ["vim-test/vim-test"] = {},

    ["nvim-neotest/neotest"] = {
        requires = {"antoinemadec/FixCursorHold.nvim", "vim-test/vim-test", "nvim-neotest/neotest-vim-test"},
        config = function()
            require "custom.plugins.java-test"
        end
    },

    -- overrde plugin configs
    ["nvim-treesitter/nvim-treesitter"] = {
        override_options = overrides.treesitter
    },

    ["williamboman/mason.nvim"] = {
        override_options = overrides.mason
    },

    ["kyazdani42/nvim-tree.lua"] = {
        override_options = overrides.nvimtree
    },

    ["NvChad/ui"] = {
        override_options = overrides.ui
    },

    -- Install a plugin
    ["max397574/better-escape.nvim"] = {
        event = "InsertEnter",
        config = function()
            require("better_escape").setup()
        end
    },

    -- code formatting, linting etc
    ["jose-elias-alvarez/null-ls.nvim"] = {
        after = "nvim-lspconfig",
        config = function()
            require "custom.plugins.null-ls"
        end
    },

    ["simrat39/rust-tools.nvim"] = {
        after = "nvim-lspconfig",
        config = function()
            require "custom.plugins.rust-tools"
        end
    },
    ["keaising/im-select.nvim"] = {
        config = function()
            require('im_select').setup {
                -- IM will be set to `default_im_select` in `normal` mode(`EnterVim` or `InsertLeave`)
                -- For Windows, default: "1003", aka: English US Keyboard
                -- You can use `im-select` in cli to get the IM name of you preferred
                default_im_select = "1033",

                -- Set to 1 if you don't want restore IM status when `InsertEnter`
                disable_auto_restore = 1
            }
        end
    },

    ["tpope/vim-unimpaired"] = {},

    ["gaving/vim-textobj-argument"] = {}

    -- remove plugin
    -- ["hrsh7th/cmp-path"] = false,
}
