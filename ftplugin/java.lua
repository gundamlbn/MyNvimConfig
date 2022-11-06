-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
    -- Mappings.
    local opts = {
        noremap = true,
        silent = true
    }
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    -- buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    -- 重命名
    buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    -- 智能提醒，比如：自动导包 已经用lspsaga里的功能替换了
    buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    -- buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap("n", "<S-C-j>", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.set_loclist()<CR>", opts)
    -- 代码格式化
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    -- buf_set_keymap("n", "<leader>l", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    -- buf_set_keymap("n", "<leader>l", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    -- 自动导入全部缺失的包，自动删除多余的未用到的包
    buf_set_keymap("n", "<A-o>", "<cmd>lua require'jdtls'.organize_imports()<CR>", opts)
    -- 引入局部变量的函数 function to introduce a local variable
    buf_set_keymap("n", "crv", "<cmd>lua require('jdtls').extract_variable()<CR>", opts)
    buf_set_keymap("v", "crv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
    -- function to extract a constant
    buf_set_keymap("n", "crc", "<Cmd>lua require('jdtls').extract_constant()<CR>", opts)
    buf_set_keymap("v", "crc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", opts)
    -- 将一段代码提取成一个额外的函数function to extract a block of code into a method
    buf_set_keymap("v", "crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)

    -- 代码保存自动格式化formatting
    -- vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]

    -- 增加额外命令
    require('jdtls.setup').add_commands()

end

local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = { -- 💀
    'java', -- or '/path/to/java17_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.
    '-Declipse.application=org.eclipse.jdt.ls.core.id1', '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product', '-Dlog.protocol=true', '-Dlog.level=ALL', '-Xms1g',
    '--add-modules=ALL-SYSTEM', '--add-opens', 'java.base/java.util=ALL-UNNAMED', '--add-opens',
    'java.base/java.lang=ALL-UNNAMED', -- 💀
    '-jar',
    'C:/Users/liubin0093/AppData/Local/nvim-data/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    -- Must point to the                                                     Change this to
    -- eclipse.jdt.ls installation                                           the actual version

    -- 💀
    '-configuration', 'C:/Users/liubin0093/AppData/Local/nvim-data/mason/packages/jdtls/config_win', -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- Must point to the                      Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            Depending on your system.
    -- 💀
    -- See `data directory configuration` section in the README
    '-data', 'C:/Users/liubin0093/AppData/Local/nvim-data/mason/packages/jdtls/workspace/folder'},

    -- 💀
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {}
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = {}
    },

    on_attach = on_attach
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)

-- local current_buff = vim.api.nvim_get_current_buf
-- -- 在语言服务器附加到当前缓冲区之后
-- -- 使用 on_attach 函数仅映射以下键
-- local java_on_attach = function(client, bufnr)
--     local function buf_set_keymap(...)
--         vim.api.nvim_buf_set_keymap(bufnr, ...)
--     end
--     local function buf_set_option(...)
--         vim.api.nvim_buf_set_option(bufnr, ...)
--     end

--     -- Enable completion triggered by <c-x><c-o>
--     buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
--     -- Mappings.
--     local opts = {
--         noremap = true,
--         silent = true
--     }
--     -- See `:help vim.lsp.*` for documentation on any of the below functions
--     buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
--     buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
--     -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
--     buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
--     -- buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--     buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
--     buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
--     buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
--     buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
--     -- 重命名
--     buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
--     -- 智能提醒，比如：自动导包 已经用lspsaga里的功能替换了
--     buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
--     buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
--     buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
--     -- buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--     buf_set_keymap("n", "<S-C-j>", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
--     buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
--     -- 代码格式化
--     buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
--     -- buf_set_keymap("n", "<leader>l", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
--     -- buf_set_keymap("n", "<leader>l", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
--     -- 自动导入全部缺失的包，自动删除多余的未用到的包
--     buf_set_keymap("n", "<A-o>", "<cmd>lua require'jdtls'.organize_imports()<CR>", opts)
--     -- 引入局部变量的函数 function to introduce a local variable
--     buf_set_keymap("n", "crv", "<cmd>lua require('jdtls').extract_variable()<CR>", opts)
--     buf_set_keymap("v", "crv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
--     -- function to extract a constant
--     buf_set_keymap("n", "crc", "<Cmd>lua require('jdtls').extract_constant()<CR>", opts)
--     buf_set_keymap("v", "crc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", opts)
--     -- 将一段代码提取成一个额外的函数function to extract a block of code into a method
--     buf_set_keymap("v", "crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)

--     -- 代码保存自动格式化formatting
--     -- vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
-- end

-- java_on_attach(nil, current_buff)
