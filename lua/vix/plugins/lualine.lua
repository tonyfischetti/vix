
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  -- black  = '#080808',
  black  = '#121212',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',

  salmon = '#ffaf87',
  lavender = '#8787d7',
  purplepink = '#d787d7',
  paynes = '#131a24'
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.lavender },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = colors.paynes },
    -- c = { fg = colors.black, bg = colors.black },
  },

  insert = { a = { fg = colors.black, bg = colors.salmon } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    -- a = { fg = colors.black, bg = colors.black }, ...
    a = { fg = colors.black, bg = colors.paynes },
    b = { fg = colors.black, bg = colors.paynes },
    c = { fg = colors.black, bg = colors.paynes },
  },
}

require('lualine').setup {
  options = {
    theme = bubbles_theme,
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '', right = ''}, right_padding = 0 },
    },
    lualine_b = { 'filename', 'branch' },
    lualine_c = { 'fileformat' },
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}
