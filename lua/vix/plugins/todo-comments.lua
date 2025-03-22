
--  TODO  (introduces dependency on `ripgrep`)

return {

  {
    "folke/todo-comments.nvim",
    keys = {
      { "<Space>t", "<cmd>TodoTelescope<CR>" }
    },
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keywords = {
        CODEX = { icon = "✎", color = "warning", alt = { "CDX", "DOCUMENT" } },
      },
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

