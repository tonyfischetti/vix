local sutils = require('../vix/lib/slime-utils')

return {

  {
    "jpalardy/vim-slime",
    -- lazy = false,
    cmd = { "SlimeConfig" },
    ft = {
      "haskell",
    },
    keys = {
      { "<Leader>ss", function() sutils.new_slime(nil, true) end, },
      { "<Leader>sr", function() sutils.new_slime("R", true) end, },
      { "<Leader>sR", function() sutils.new_slime("RR", true ) end, },
      { "<Leader>sc", function()
        vim.ui.input("Starting command: ",
          function(input)
            sutils.new_slime(input, true)
          end)
        end
      }
    },
    init = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_no_mappings = 1
      vim.g.slime_haskell_ghci_add_let = 0
    end
  }

}
