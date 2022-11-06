local present, cmp = pcall(require, "cmp")

if not present then
    return
end

local sources = {{
    name = 'cmp_tabnine'
}, {
    name = 'nvim_lsp'
}, {
    name = 'luasnip'
}, {
    name = 'buffer'
}, {
    name = 'path'
}, {
    name = 'nvim_lua'
}}

cmp.setup {
    sources = sources
}
