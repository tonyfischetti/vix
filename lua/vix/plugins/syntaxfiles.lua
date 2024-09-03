
return {

  {
    "vieira/vim-javascript",
    ft = { "javascript", "typescript" }
  },

  {
    "bfrg/vim-cpp-modern",
    ft = { "c", "cpp" }
  },

  {
    -- TODO
    "vim-pandoc/vim-pandoc-syntax",
    ft = "markdown"
  },

  {
    "pprovost/vim-ps1",
    ft = { "ps1" }
  },

  {
    "evanleck/vim-svelte",
    ft = { "svelte" },
    dependencies = {
      { "othree/html5.vim" }
    }
  },

}
