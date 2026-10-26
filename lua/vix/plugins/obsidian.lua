
-- obsidian-nvim/obsidian.nvim is the maintained community fork of
-- epwalsh/obsidian.nvim (which stopped at v3.9.0, july 2024).
-- differences from the old config that matter here:
--   - one `:Obsidian <sub>` command (legacy ObsidianFoo commands off)
--   - completion is an in-process LSP ("obsidian-ls"), picked up by
--     nvim-cmp through cmp-nvim-lsp; no `completion.nvim_cmp` any more
--   - `<CR>` is bound by the plugin itself ("smart action": follow link,
--     toggle checkbox, cycle heading fold), so no custom `mappings`
--   - `follow_url_func` gone; URLs open with vim.ui.open by default
--   - `note_frontmatter_func` is now `frontmatter.func`
--   - checkbox glyphs are the plugin defaults (they match what was
--     configured before); the toggle *order* is `checkbox.order`. setting
--     `ui.checkboxes` at all makes the plugin warn on every start
--   - plenary is no longer a dependency

return {

  {
    'obsidian-nvim/obsidian.nvim',
    version = "*",
    ft = "markdown",
    -- global (they load the plugin): usable from any buffer
    keys = {
      { "<Leader>ot", "<cmd>Obsidian today<CR>",        desc = "obsidian: today's note" },
      { "<Leader>oo", "<cmd>Obsidian quick_switch<CR>", desc = "obsidian: switch to a note" },
      { "<Leader>os", "<cmd>Obsidian search<CR>",       desc = "obsidian: grep the vault" },
      { "<Leader>on", "<cmd>Obsidian new<CR>",          desc = "obsidian: new note" },
      { "<Leader>og", "<cmd>Obsidian tags<CR>",         desc = "obsidian: tags" },
      { "<Leader>oa", "<cmd>Obsidian open<CR>",         desc = "obsidian: open in the app" },
    },

    opts = {

      legacy_commands = false,

      workspaces = {
        {
          name = "obsidian",
          path = "~/Dropbox/Carlos IV/Obsidian/"
        },
      },

      completion = {
        min_chars = 2,
      },

      picker = {
        name = "telescope.nvim",
      },

      callbacks = {
        -- like the app: the note list opens by itself while typing a
        -- `[[link` (nvim-cmp is in manual mode everywhere else). it opens
        -- once `completion.min_chars` characters follow the brackets --
        -- not at `[[` itself, because obsidian-ls answers that with nothing
        -- and cmp would then sit on the empty answer. an autocmd rather
        -- than an insert mapping on "[[", which would make every single
        -- "[" wait on timeoutlen
        enter_note = function()
          local buf = vim.api.nvim_get_current_buf()
          if vim.b[buf].vix_wikilink_complete then return end
          vim.b[buf].vix_wikilink_complete = true
          vim.api.nvim_create_autocmd("TextChangedI", {
            buffer = buf,
            callback = function()
              local ok, cmp = pcall(require, "cmp")
              if not ok or cmp.visible() then return end
              local col = vim.api.nvim_win_get_cursor(0)[2]
              local query = vim.api.nvim_get_current_line():sub(1, col):match("%[%[([^%[%]]*)$")
              local need = (Obsidian and Obsidian.opts.completion.min_chars) or 2
              if query and vim.fn.strchars(query) == need then
                cmp.complete()
              end
            end,
          })
        end,
      },

      new_notes_location = "notes_subdir",

      -- match the app's "Default location for new attachments"
      -- (.obsidian/app.json attachmentFolderPath); paste_img needs pngpaste
      attachments = {
        folder = "_attachments",
      },

      daily_notes = {
        folder = "Daily Notes",
        template = "daily",
        -- the app's daily notes carry no tags; the plugin would add
        -- "daily-notes" by default
        default_tags = {},
      },

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

      frontmatter = {
        func = function(note)
          -- id + tags only (deliberately no aliases), keeping any fields
          -- that were added to the frontmatter by hand
          local out = { id = note.id, tags = note.tags }
          if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
            for k, v in pairs(note.metadata) do
              out[k] = v
            end
          end
          return out
        end,
      },

      templates = {
        folder = "_templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        substitutions = {},
      },

      checkbox = {
        order = { " ", ">", "!", "x" },
      },

    }

  }

}
