
-- alternative colorschemes. `lcars` (colors/lcars.vim, own file) is the
-- one in use, so none of these need to be on the startup path: they are
-- `lazy = true` and get loaded by the <Leader>cc picker (telescope.lua),
-- which loads every plugin that ships a colors/ directory before listing.
-- `:colorscheme <name>` by hand won't see them until that has happened.

return {

  -- gotham
  {
    "whatyouhide/vim-gotham",
    lazy = true,
  },

  -- tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "night" }
  },

  -- nightfox
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
  },

  -- fluoromachine
  -- TODO: good start. customize some colors
  {
    'maxmx03/fluoromachine.nvim',
    lazy = true,
    opts = {
      glow = false,
      theme = 'retrowave',
      transparent = true,
      brightness = 0.2
    }
  },

  {
    "https://github.com/mhartington/oceanic-next",
    lazy = true,
  },

  {
    "alexmozaidze/palenight.nvim",
    lazy = true,
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = true,
  },

  {
    "oxfist/night-owl.nvim",
    lazy = true,
  }

}
