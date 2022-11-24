-- local present, rt = pcall(require, "rust-tools")
-- if not present then
--     return
-- end
local rt = require("rust-tools")

local function on_attach(client, bufnr)
    require("plugins.configs.lspconfig").on_attach(client, bufnr)
    -- This callback is called when the LSP is atttached/enabled for this buffer
    -- we could set keymaps related to LSP, etc here.
    -- Hover actions
    vim.keymap.set("n", "<C-a>", rt.hover_actions.hover_actions, {
        buffer = bufnr
    })
    -- Code action groups
    vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, {
        buffer = bufnr
    })
end

local opts = {
    tools = {
        runnables = {
            use_telescope = true
        },
        inlay_hints = {
            auto = true,
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = ""
        }
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        cmd = {"C:/Users/liubin0093/AppData/Local/nvim-data/mason/packages/rust-analyzer/rust-analyzer.exe"},
        -- on_attach is a callback called when the language server attachs to the buffer
        on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                }
            }
        }
    }
}
rt.setup(opts)
