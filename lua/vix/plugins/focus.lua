
return {

  {
    "miversen33/sunglasses.nvim",
    opts = {
      filter_type = "SHADE",
      -- filter_type = "NOSYNTAX",
      filter_percent = .5
    }
  },

  {
    "shortcuts/no-neck-pain.nvim",
    cmd = "NoNeckPain"
  },

  {
    "szw/vim-maximizer",
    keys = {
      { "<Space>z", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
    },
  },

  {
    "simeji/winresizer",
    init = function()
      vim.g.winresizer_horiz_resize = 2;
      vim.g.winresizer_vert_resize  = 5;
    end,
    keys = {
      { "<Space>e",  "<cmd>:WinResizerStartResize<CR>", desc = "Enter 'resize' mode" },
    }
  },

}
