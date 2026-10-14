
return {

  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    init = function()
      -- the require is inside the function on purpose: requiring it here
      -- would load the plugin at startup and defeat `event = "LspAttach"`
      vim.keymap.set("n", "K", function() require("pretty_hover").hover() end, { desc = "pretty hover" })
    end,
    opts = {}
  },

}
