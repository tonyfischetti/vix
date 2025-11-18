
return {

  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'LspAttach',
    -- opts = {
    --   show_all_diags_on_cursorline = false,
    --   show_source = {
    --     enabled = true,
    --   },
    -- },
    config = function()
      local tid = require('tiny-inline-diagnostic')
      tid.setup({

        options = {
          show_all_diags_on_cursorline = false,
          show_diags_only_under_cursor = true,
        },

      })
    end
  },

}

