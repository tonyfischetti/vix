
return {

  {
    "folke/snacks.nvim",
    priority = 1000,
    opts = {
      input = {
      },
      bigfile = {
      },
      styles = {
        input = {
          height = 1,
          row=5
        }
      }
    }
  },


  --  TODO: find a use for this
  {
    'rcarriga/nvim-notify',
    opts = {
      stages = "static",
      timeout = 2000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
  }

}
