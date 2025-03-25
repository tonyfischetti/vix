
return {

  -- TODO: 
  {
    'numToStr/FTerm.nvim',
    init = function()
      vim.keymap.set('n', '<Space>mm', '<CMD>lua require("FTerm").toggle()<CR>')
    end
  }

}

