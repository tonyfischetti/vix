
return {
  {
    -- no idea
    "brenoprata10/nvim-highlight-colors",
    lazy = false,
    -- TODO: how come below is necessary?
    config = function()
      require('nvim-highlight-colors').setup({})
    end
  }
}
