
return {

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- keywords = {
      --   CUSTOM = { icon = " ", color = "warning" },
      -- },
      highlight = {
        comments_only = false,
        after = ""   -- the rest of the comment wont have the custom color
      }
    }
  }

}

