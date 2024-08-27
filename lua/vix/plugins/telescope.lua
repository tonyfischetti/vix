
return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-symbols.nvim'
    },
    keys = {

      {
        "<Space>a", function() require("telescope.builtin").git_files() end,
        desc = "Fuzzy find files in git repository",
      },
      {
        "<Leader>a", function() require("telescope.builtin").git_files() end,
        desc = "Fuzzy find files in git repository",
      },
      {
        "<Leader>f", function() require("telescope.builtin").find_files() end,
        desc = "Fuzzy find files (regular)",
      },

      {
        "<Leader>cc", function() require("telescope.builtin").colorscheme() end,
        desc = "Fzf colorschemes",
      },

      {
        "<Leader>sy", function() require("telescope.builtin").symbols() end,
        desc = "Fzf symbols",
      },

      {
        "<Leader>/", function() require("telescope.builtin").buffers() end,
        desc = "Fzf open buffers",
      },
      {
        "<Space>/", function() require("telescope.builtin").buffers() end,
        desc = "Fzf open buffers",
      },
      {
        "<Leader>gr", function() require("telescope.builtin").live_grep() end,
        desc = "Live grep",
      },

    },

    opts = {
      defaults = {
        mappings = {
          i = {
            ["<ESC>"] = require("telescope.actions").close,
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
          },

        },
        sorting_strategy   = "ascending",
        layout_config = {
          prompt_position = "top",
        }
      },
      pickers = {
        find_files = {
          find_command = { "ack", "-f" },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        }
      }
    }
  }
}

