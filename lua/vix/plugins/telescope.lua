
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
        "<Space>d", function() require("telescope.builtin").diagnostics() end,
        desc = "Telescope diagnostics",
      },
      {
        "<Space>mm", function() require("telescope.builtin").marks() end,
        desc = "Telescope marks",
      },

      {
        "<Space>o", function() require("telescope").extensions.project.project() end,
        desc = "TODO",
      },
      {
        "<Space>pa", function () require("telescope._extensions.project.actions").add_project() end,
        desc = "TODO"
      },
      {
        "<Space>pr", function () require("telescope._extensions.project.actions").rename_project() end,
        desc = "TODO"
      },
      {
        "<Space>pd", function () require("telescope._extensions.project.actions").delete_project() end,
        desc = "TODO"
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
          },

        },
        layout_config = {
          prompt_position = "top",
        },
        sorting_strategy   = "ascending",
        -- path_display = function(opts, path)
        --   local basename  = require("telescope.utils").path_tail(path)
        --   local separator = require("telescope.utils").get_separator()
        --   local dirs      = vim.split(path, "/")
        --   local init      = utils.array_init(dirs)
        --   local dirname   = table.concat(init, separator)
        --   local spacing   = 50 - string.len(basename)
        --   if spacing < 0 then
        --     spacing = 0
        --   end
        --   path = string.format("%s%s%s", basename, string.rep(" ", spacing), dirname)
        --   return path
        -- end,
        path_display = { 'smart' }
      },
      pickers = {
        find_files = {
          --  HACK: introduces dependency on ack
          find_command = { "ack", "-f" },
        },
        marks = {
          entry_maker = function(mark)
            -- get the mark letter (handles :marks-style rows)
            local function mark_label(m)
              if type(m) ~= "table" then return "" end
              if type(m.mark) == "string" and #m.mark > 0 then return m.mark end
              if type(m.value) == "string" and #m.value > 0 then return m.value end
              if type(m.line)  == "string" then
                local tok = m.line:match("^%s*(%S+)")  -- first token in the line
                return tok or ""
              end
              return ""
            end

            local label = mark_label(mark)

            -- hide numeric & common special/system marks
            -- keep only your named a–z/A–Z marks
            if label:match("^%d$") or label:match('[\"\'`%^%[%]<>%.]') then
              return nil
            end

            -- build the default entry
            local default = require('telescope.make_entry').gen_from_marks()
            local e = default(mark)
            if not e then return nil end

            -- columns
            local displayer = require('telescope.pickers.entry_display').create({
              separator = " ",
              items = {
                { width = 3  },       -- mark letter
                { width = 30 },       -- filename tail
                { width = 6  },       -- :lnum
                { remaining = true }, -- → snippet
              },
            })

            -- resolve filename/buffer/line
            local filename = e.filename or e.path or e.file
            if not filename and e.bufnr and e.bufnr > 0 then
              filename = vim.api.nvim_buf_get_name(e.bufnr)
            end
            local bufnr = e.bufnr
            local lnum  = e.lnum or (type(e.pos) == "table" and e.pos[2]) or mark.lnum or 1
            local tail  = filename and vim.fn.fnamemodify(filename, ":t") or "[No Name]"

            -- snippet: prefer loaded buffer, else read file
            local line_text, got = "", false
            if bufnr and bufnr > 0 and vim.api.nvim_buf_is_loaded(bufnr) then
              local ok, lines = pcall(vim.api.nvim_buf_get_lines, bufnr, lnum - 1, lnum, false)
              if ok and lines and lines[1] then line_text, got = lines[1], true end
            end
            if not got and filename and vim.loop.fs_stat(filename) then
              local ok, lines = pcall(vim.fn.readfile, filename)
              if ok and lines and lines[lnum] then line_text = lines[lnum] end
            end
            line_text = (line_text or ""):gsub("^%s+", ""):gsub("%s+$", "")
            if #line_text > 80 then line_text = line_text:sub(1, 77) .. "..." end

            -- final display
            e.display = function()
              return displayer({
                { label ~= "" and label or "?", "TelescopeResultsSpecialComment" },
                { tail,                           "TelescopeResultsIdentifier" },
                { ":" .. tostring(lnum),          "TelescopeResultsLineNr" },
                { "→ " .. line_text },
              })
            end

            return e
          end,
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
          sync_with_nvim_tree = true, -- default false
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

