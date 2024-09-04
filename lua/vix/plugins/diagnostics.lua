
return {

  {
    'RaafatTurki/corn.nvim',
    init = function()
      vim.diagnostic.config({ virtual_text = false })
    end,
    opts = {
      item_preprocess_func = function(item)
        return item
      end
    }
  }

}
