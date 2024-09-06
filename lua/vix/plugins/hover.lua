
return {

  {
    "Fildo7525/pretty_hover",
    --  TODO  important for other plugins
    event = "LspAttach",
    init = function()
      vim.keymap.set("n", "K", require("pretty_hover").hover, {desc = "hover.nvim"})
    end,
    opts = {}
  },

}
