
return {

  -- TODO: 
  {
    'numToStr/FTerm.nvim',
    init = function()
      vim.keymap.set('n', '<Space>M', '<CMD>lua require("FTerm").toggle()<CR>')
    end
  }

}

