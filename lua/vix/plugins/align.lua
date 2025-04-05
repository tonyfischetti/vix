
return {

  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.align').setup({
        mappings = {
          start = '',
          start_with_preview = 'ga',
        },
      })
    end
  }

}

--   {
--     'Vonr/align.nvim',
--     branch = "v2",
--     lazy = true,
--     init = function()
--       local NS = { noremap = true, silent = true }
--
--
--       -- Aligns to a string with previews
--       vim.keymap.set(
--       'v',
--       'aw',
--       function()
--         require'align'.align_to_string({
--           preview = true,
--           regex = false,
--         })
--       end,
--       NS
--       )
--
--       -- Aligns to a Vim regex with previews
--       vim.keymap.set(
--       'v',
--       'ar',
--       function()
--         require'align'.align_to_string({
--           preview = true,
--           regex = true,
--         })
--       end,
--       NS
--       )
--     end
--   }
--
-- }
