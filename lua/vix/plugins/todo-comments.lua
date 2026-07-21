
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
        after = ""
      },
    },
    config = function(_, opts)
      require("todo-comments").setup(opts)

      -- Upstream bug (still present in v1.5.0): the default "wide"
      -- keyword style pads the extmark one column PAST the keyword
      -- (`finish + 1`, highlight.lua:246). When the keyword ends the
      -- line -- i.e. every time you're mid-typing one -- that throws
      -- "Invalid 'end_col': out of range". Rather than give up the
      -- wide look (keyword = "bg" avoids it but loses the padding),
      -- clamp every end_col to the line length, but only while the
      -- plugin's highlighter is running: full padding when there's a
      -- character to pad onto, exact range at end-of-line. Delete
      -- this wrapper if upstream ever clamps it themselves.
      local hl = require("todo-comments.highlight")
      local orig_highlight = hl.highlight
      hl.highlight = function(...)
        local real = vim.api.nvim_buf_set_extmark
        vim.api.nvim_buf_set_extmark = function(buf, ns, row, col, o)
          if o and o.end_col then
            local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, false)[1] or ""
            o.end_col = math.min(o.end_col, #line)
            col = math.min(col, #line)
          end
          return real(buf, ns, row, col, o)
        end
        local ok, err = pcall(orig_highlight, ...)
        vim.api.nvim_buf_set_extmark = real
        if not ok then error(err) end
      end
    end,
  }

}
