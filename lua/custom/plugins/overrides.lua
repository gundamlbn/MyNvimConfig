local M = {}

M.treesitter = function()
    -- java反编译的class高亮
    local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
    ft_to_parser.class = "java"

    return {
        ensure_installed = {"vim", "lua", "html", "css", "typescript", "c", "java", "rust", "astro", "markdown"}
    }
end

M.mason = {
    ensure_installed = { -- lua stuff
    -- "lua-language-server",
    -- "stylua", 
    -- web dev stuff
    "css-lsp", "html-lsp", "typescript-language-server", -- "deno",
    -- java dev stuff
    "jdtls", "rust-analyzer", "rustfmt", -- astro
    "astro-language-server"}
}

-- git support in nvimtree
M.nvimtree = {
    git = {
        enable = true
    },

    renderer = {
        highlight_git = true,
        icons = {
            show = {
                git = true
            }
        }
    }
}

M.ui = {
    statusline = {
        overriden_modules = function()
            return require "custom.plugins.statusline_session"
        end
    }
}

return M
