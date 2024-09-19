
return {

  {
    'epwalsh/obsidian.nvim',
    version = "*",
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<Leader>ot", ":ObsidianToday<CR>" }
    },

    opts = {

      workspaces = {
        {
          name = "obsidian",
          path = "~/Dropbox/Carlos IV/Obsidian/"
        },
      },

      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },

      new_notes_location = "notes_subdir",

      daily_notes = {
        folder = "Daily Notes",
        template = "daily"
      },

      mappings = {
        ["<cr>"] = {
          action = function()
            if require("obsidian").util.cursor_on_markdown_link(nil, nil, true) then
              return "<cmd>ObsidianFollowLink<CR>"
            end
          end,
          opts = { buffer = true, expr = true },
        }
      },

      follow_url_func = function(url)
        vim.ui.open(url)
      end,

      note_id_func = function(title)
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          return title
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. "-" .. suffix
      end,

      -- stem is messed
      note_path_func = function(spec)
        local path = spec.dir / tostring(spec.id)
        -- require('notify').notify(spec.dir)
        -- require('notify').notify(path.name)
        -- require('notify').notify(path.name)
        -- require('notify').notify(path.suffix
        -- require('notify').notify(path.filename)
        -- return path:with_suffix(".md")
        -- return path.filename .. ".md"
        local firstpart = path.stem
        if path.suffix then
          firstpart = firstpart .. path.suffix
        end
        return firstpart .. ".md"
      end,


      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        -- NO!
        -- if note.title then
        --   note:add_alias(note.title)
        -- end
        -- local out = { id = note.id, aliases = note.aliases, tags = note.tags }
        local out = { id = note.id, tags = note.tags }
        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,

      templates = {
        folder = "_templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
      },

      ui = {
        checkboxes = {
          [" "] = { char = "▢󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["!"] = { char = "", hl_group = "ObsidianImportant" },
        }
      },

    }

  }

}
