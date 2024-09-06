
return {

  --  TODO  doesn't start when it's support to
  {
    "losingkeys/vim-niji",
    lazy = false,
    init = function()
      vim.g.niji_matching_filetypes = {'lisp', 'scheme', 'clojure', 'racket'}
    end,
    keys = {
      {
        "<Leader>P", function() vim.cmd(':call niji#highlight()') end
      }
    },
  }

}
