
return {

  -- gotham
  {
    "whatyouhide/vim-gotham",
  },

  -- tokyonight
  {
    "folke/tokyonight.nvim",
    opts = { style = "night" }
  },

  -- nightfox
  {
    "EdenEast/nightfox.nvim",
  },

  -- embark
  {
    "embark-theme/vim",
  },

  -- fluoromachine
  -- TODO: good start. customize some colors
  {
    'maxmx03/fluoromachine.nvim',
    opts = {
      glow = false,
      theme = 'retrowave',
      transparent = true,
      brightness = 0.2
    }
  },

  -- cyberdream
  -- TODO: you can change colors
  --       the light variant is cool
  {
    "scottmckendry/cyberdream.nvim",
    opts = {
      theme = {
        --   variant = "light",
        -- override color entirely
        colors = {
          -- bg = "#deaded",
          -- green = "#00ff00"
          -- orange = "#ffff87",
        },
        -- easy to override highlight groups
        overrides = function(colors)
          return {
            -- Comment = { fg = colors.green, bg = "NONE", italic = true },
            ["@property"] = { fg = colors.magenta, bold = true },
          }
        end
      }
    }
  },

  {
    "https://github.com/mhartington/oceanic-next"
  },

  {
    "https://github.com/zootedb0t/citruszest.nvim"
  },

}

