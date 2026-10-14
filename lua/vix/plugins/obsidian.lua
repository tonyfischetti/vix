
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
    keys = {
      { "<Leader>ot", "<cmd>Obsidian today<CR>", desc = "obsidian: today's note" }
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

      new_notes_location = "notes_subdir",

      daily_notes = {
        folder = "Daily Notes",
        template = "daily"
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
