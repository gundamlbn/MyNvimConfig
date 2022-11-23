-- vim.cmd([[
--     let test#strategy = {
--       \ 'nearest': 'asyncrun',
--       \ 'file':    'asyncrun_background',
--       \ 'suite':   'asyncrun_background',
--     \}
-- ]])
--
-- vim.cmd "let test#java#runner = 'maventest'"
local present, neotest = pcall(require, "neotest")

if not present then
    return
end

neotest.setup({
    adapters = {require("neotest-vim-test")({
        allow_file_types = {"java"}
    })}
})
