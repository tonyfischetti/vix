
return {

  {
    "losingkeys/vim-niji",
    init = function()
      vim.g.niji_matching_filetypes = {'lisp', 'scheme', 'clojure', 'racket'}
    end
  }

}
