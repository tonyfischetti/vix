local fns = require('../vix/lib/functions')

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      virtual_text = {
        spacing = 17,
        -- source = "always"
      }
    }
)

--  TODO: what does this do?
vim.diagnostic.config {
  virtual_text = false,
  update_in_insert = false
}

require'telescope'.load_extension('project')
require('telescope').load_extension('fzf')
