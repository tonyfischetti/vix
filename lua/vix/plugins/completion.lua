
-- TRIAL: native completion instead of nvim-cmp.
-- the whole thing lives in lua/vix/lib/completion.lua; luasnip stays
-- for the snipmate snippets in snippets/. nvim-cmp and its sources are
-- not loaded but are still in lazy-lock.json / on disk until this is
-- made permanent (`Lazy clean`) or reverted (git checkout of this file,
-- lsp.lua, and deletion of lib/completion.lua).

return {

  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    config = function()
      require("vix.lib.completion").setup()
    end
  },

}
