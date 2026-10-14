
return {

  {
    "folke/snacks.nvim",
    priority = 1000,
    opts = {
      input = {
      },
      bigfile = {
      },
      -- takes over vim.notify (popups for lsp/mason/lazy/etc. messages);
      -- history: Snacks.notifier.show_history()
      notifier = {
        timeout = 2000,
        width  = { min = 40, max = 0.75 },
        height = { min = 1,  max = 0.75 },
      },
      -- only for vim.ui.select (code actions etc.); telescope stays the finder
      picker = {
        ui_select = true,
      },
      styles = {
        input = {
          height = 1,
          row=5
        }
      }
    }
  },

}
