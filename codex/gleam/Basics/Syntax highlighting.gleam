// gleam, basics, editor, syntax highlighting, vim, neovim, language server, lsp, code actions, format on save, compiler, make

// vim and neovim know about `*.gleam` files out of the box
//
//   - the filetype is `gleam` (no modeline needed)
//   - syntax highlighting
//   - commentstring is `// %s`
//   - `:make` runs `gleam build` and fills the quickfix list
//
// The language server is built into the compiler (`gleam lsp`), so there's
// nothing else to install. In neovim, with nvim-lspconfig
//
//   vim.lsp.enable("gleam")
//
// It does diagnostics, hover, completion, go to definition, references,
// rename, inlay hints, formatting, and a lot of code actions that write
// the boring code for you. A few of them...
//
//   - Add missing patterns          (fills in the rest of a `case`)
//   - Generate function             (from a call to one that doesn't exist)
//   - Generate dynamic decoder      (from a custom type. see "JSON decode")
//   - Generate to-JSON function
//   - Convert to pipe
//   - Extract variable
//
// Format on save is `vim.lsp.buf.format()` in a BufWritePre autocmd.
// Or, without the language server
//
//   :%!gleam format --stdin
//
// For vim: https://github.com/gleam-lang/gleam.vim
