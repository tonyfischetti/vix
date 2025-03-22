
return {

  -- {
  --   'RaafatTurki/corn.nvim',
  --   init = function()
  --     vim.diagnostic.config({ virtual_text = false })
  --   end,
  --   opts = {
  --     item_preprocess_func = function(item)
  --       return item
  --     end
  --   }
  -- }

  {
    'dgagn/diagflow.nvim',
    event = 'LspAttach',
    opts = {
      show_borders = true,
      -- scope = "line",
      toggle_event = { 'InsertEnter', 'InsertLeave' },
      border_chars = {
        top_left = "╭",
        top_right = "╮",
        bottom_left = "╰",
        bottom_right = "╯",
        horizontal = "─",
        vertical = "│"
      },
    }
  }

}

