
return {
  {
    "tomtom/tcomment_vim",
    init = function()
      vim.keymap.set("v", "?", ":TComment<CR>");
    end
  }
}

