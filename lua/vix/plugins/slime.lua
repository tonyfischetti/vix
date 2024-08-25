
return {

  {
    "jpalardy/vim-slime",
    cmd = "SlimeConfig",
    init = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_no_mappings = 1
    end
  }

}
