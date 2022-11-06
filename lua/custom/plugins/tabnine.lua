local present, cmp = pcall(require, "cmp")

if not present then
    return
end

local sources = { --    {
--     name = "luasnip"
-- }, {
--     name = "nvim_lsp"
-- }, {
--     name = "buffer"
-- }, {
--     name = "nvim_lua"
-- }, {
--     name = "path"
-- }, 
{
    name = 'cmp_tabnine'
}}

cmp.setup {
    sources = sources
}
