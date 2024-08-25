
return {

  {
    "brenoprata10/nvim-highlight-colors",
    -- TODO: how come below is necessary?
    config = function()
      require('nvim-highlight-colors').setup({})
    end
  },

  {
    "https://github.com/rktjmp/lush.nvim"
  }

}
