
return {

  -- TODO: look at more options
  {
    "voldikss/vim-floaterm",
    init = function()
      vim.g.floaterm_width = 0.7
      vim.g.floaterm_title = '  floatterm  '
      -- vim.g.floaterm_rootmarkers = {
      --   '.project',
      --   '.git',
      --   '.hg',
      --   '.svn',
      --   '.root',
      --   'package.json'
      -- }
    end,
    keys = {
      { "<Leader>m", ":FloatermToggle<CR>" },
      -- TODO: doesn't work
      -- { "<C-m>", ":FloatermToggle<CR>", "t" },
      -- -- TODO: doesn't work
      -- { "<Leader>M", ":FloatermNew --cwd=<root><CR>" }
    },
    -- opts = {}
  }
}
