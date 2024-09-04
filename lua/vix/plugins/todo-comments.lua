
--  TODO  (introduces dependency on `ripgrep`)

return {

  {
    "folke/todo-comments.nvim",
    keys = {
      { "<Leader>tt", "<cmd>TodoTelescope<CR>" }
    },
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      search = {
        pattern = [[\b(KEYWORDS)\b]],
      },
      highlight = {
        pattern = [[.*<((KEYWORDS))>]],
        comments_only = true,
        after = " "
      },
    }
  }

}

