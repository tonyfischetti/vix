
local lspconfig = require 'lspconfig'

lspconfig.tsserver.setup({
  disableSuggestions = true
})

lspconfig.r_language_server.setup({
  on_attach = on_attach_custom,
  flags = { debounce_text_changes = 150 },
})

-- vim.api.nvim_create_autocmd('FileType', {
--   -- This handler will fire when the buffer's 'filetype' is "python"
--   pattern = 'typescript',
--   callback = function(args)
--     vim.lsp.start({
--       name = 'typescript',
--       cmd = {'name-of-language-server-executable', '--option', 'arg1', 'arg2'},
--       -- Set the "root directory" to the parent directory of the file in the
--       -- current buffer (`args.buf`) that contains either a "setup.py" or a
--       -- "pyproject.toml" file. Files that share a root directory will reuse
--       -- the connection to the same LSP server.
--       root_dir = vim.fs.root(args.buf, {'setup.py', 'pyproject.toml'}),
--     })
--   end,
-- })
--
