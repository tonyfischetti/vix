
return {

  {
    "losingkeys/vim-niji",
    lazy = true,
    init = function()
      vim.g.niji_matching_filetypes = {'lisp', 'scheme', 'clojure', 'racket'}
    end,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {"lisp", "scheme", "racket", "clojure"},
        callback = function()
          -- Defer to ensure plugin is fully loaded
          vim.schedule(function()
            vim.cmd('call niji#highlight()')
          end)
        end,
      })
    end,
    ft = { "lisp", "scheme", "racket", "clojure" },
    keys = {
      {
        "<Leader>P", function() vim.cmd(':call niji#highlight()') end
      }
    },
  }

}
