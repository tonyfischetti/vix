
return {

  {
    'epwalsh/obsidian.nvim',
    version = "*",
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
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

    },

  }

}
