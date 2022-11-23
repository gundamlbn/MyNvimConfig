local present, null_ls = pcall(require, "null-ls")

if not present then
    return
end

local b = null_ls.builtins

local sources = { -- webdev stuff
b.formatting.deno_fmt, b.formatting.prettier.with {
    filetypes = {"html", "markdown", "css"}
}, -- Lua
b.formatting.stylua, -- Shell
b.formatting.shfmt, b.diagnostics.shellcheck.with {
    diagnostics_format = "#{m} [#{c}]"
}, -- cpp
b.formatting.clang_format, b.formatting.rustfmt}

local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end

null_ls.setup {
    debug = true,
    sources = sources,

    -- -- format on save
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.rs",
                callback = function()
                    vim.lsp.buf.formatting_sync(nil, 200)
                end,
                group = format_sync_grp
            })
        end

    end
}
