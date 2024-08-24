
return {

  {
    "karb94/neoscroll.nvim",
    config = function()
      local neoscroll = require('neoscroll')
      neoscroll.setup({
      })
      local keymap = {
        ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 180; info = 'cursorline' }) end;
        ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 180; info = 'cursorline' }) end;
      }
      local modes = { 'n', 'v', 'x' }
      for key, func in pairs(keymap) do
        vim.keymap.set(modes, key, func)
      end
    end
  },

  {
    "petertriho/nvim-scrollbar",
    opts = {
      handle = {
        color = "#4E4E4E",
        cterm = 239,
        highlight = "ColorColumn",
        hide_if_all_visible = true
      }
    }
  }

}

