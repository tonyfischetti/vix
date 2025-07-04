
--  TODO  introduces dependency on rg
--  TODO  introduces dependency on git

local utils = require('../vix/lib/utils')


return {

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-symbols.nvim',
      'tonyfischetti/telescope-project.nvim',
      'tonyfischetti/telescope-cmdline.nvim',
      --  TODO  introduces dependency on gcc/clang and make
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    keys = {

      {
        "<Leader>cc", function() require("telescope.builtin").colorscheme() end,
        desc = "Fzf colorschemes",
      },
      {
        "<Leader>sy", function() require("telescope.builtin").symbols() end,
        desc = "Fzf symbols",
      },

      {
        "<Space>/", function() require("telescope.builtin").find_files({ cwd = utils.get_find_files_root() }) end,
        desc = "TODO"
      },
      {
        "<Space>f", function() require("telescope.builtin").git_files() end,
        desc = "Fuzzy find files in git repository",
      },
      {
        "<Space>?", function() require("telescope.builtin").buffers() end,
        desc = "Fzf open buffers",
      },
      {
        "<Space>g", function()
          require("telescope.builtin").live_grep({ cwd = utils.get_find_files_root() }) end,
        desc = "Live grep",
      },

      {
        "<Space>o", function() require("telescope").extensions.project.project() end,
        desc = "TODO",
      },
      {
        "<Space>:", "<CMD>Telescope cmdline<CR>", desc = "Cmdline"
      },

    },

    opts = {
      defaults = {
        mappings = {
          i = {
            -- ["<ESC>"] = require("telescope.actions").close,
            -- ["<C-j>"] = require("telescope.actions").move_selection_next,
            -- ["<C-k>"] = require("telescope.actions").move_selection_previous,
            -- (new) defaults from telescope-project
            -- map('i', '<c-d>', _actions.delete_project)
            -- map('i', '<c-r>', _actions.rename_project)
            -- map('i', '<c-p>', _actions.add_project)
          },

        },
        layout_config = {
          prompt_position = "top",
        },
        sorting_strategy   = "ascending",
        path_display = function(opts, path)
          local basename  = require("telescope.utils").path_tail(path)
          local separator = require("telescope.utils").get_separator()
          local dirs      = vim.split(path, "/")
          local init      = utils.array_init(dirs)
          local dirname   = table.concat(init, separator)
          local spacing   = 50 - string.len(basename)
          if spacing < 0 then
            spacing = 0
          end
          path = string.format("%s%s%s", basename, string.rep(" ", spacing), dirname)
          return path
        end,
      },
      pickers = {
        find_files = {
          --  HACK: introduces dependency on ack
          find_command = { "ack", "-f" },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        project = {
          -- base_dirs = {
          --   '~/dev/',
          -- },
          -- hidden_files = true, -- default: false
          -- theme = "dropdown",
          -- order_by = "asc",
          -- search_by = "title",
          -- sync_with_nvim_tree = true, -- default false
          -- default for on_project_selected = find project files
          on_project_selected = function(prompt_bufnr)
            local project_actions = require("telescope._extensions.project.actions")
            local actions_state   = require("telescope.actions.state")
            local sel_root        = actions_state.get_selected_entry(prompt_bufnr).value
            project_actions.change_working_directory(prompt_bufnr, false)
            utils.set_proj_proj_root(sel_root)
            require("telescope.builtin").find_files()
          end
        },
      }
    }
  }

}

