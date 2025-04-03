
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
  }

}
