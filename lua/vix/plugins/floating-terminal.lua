
return {

  -- TODO: 
  {
    'numToStr/FTerm.nvim',
    init = function()
      vim.keymap.set('n', '<Leader>te', '<CMD>lua require("FTerm").toggle()<CR>')
      -- TODO:
      vim.keymap.set('n', '<Leader>mm', '<CMD>lua require("FTerm").run("ls")<CR>')
    end
  }

}

