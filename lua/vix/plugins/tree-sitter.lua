
return {

  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    -- init = function(plugin)
    --   -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    --   -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    --   -- no longer trigger the **nvim-treesitter** module to be loaded in time.
    --   -- Luckily, the only things that those plugins need are the custom queries, which we make available
    --   -- during startup.
    --   require("lazy.core.loader").add_to_rtp(plugin)
    --   require("nvim-treesitter.query_predicates")
    -- end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { "<c-space>", desc = "Increment Selection" },
      { "<bs>", desc = "Decrement Selection", mode = "x" },
    },
    --  TODO  I'm pretty sure I don't want it to auto install
    opts_extend = { "ensure_installed" },
    opts = {
      highlight = {
        --  TODO  I'm pretty sure I want this off
        enable = true,
        disable = {
          "r",
          "lisp",
          -- "typescript",
          -- "javascript",
          "tsx",
          "jsx",
          "cpp",
          "sql",
          "html",
        },
      },
      indent = { enable = false },
      ensure_installed = {
        "bash",
        "c",
        "cmake",
        "commonlisp",
        "cpp",
        "css",
        "csv",
        "diff",
        "dockerfile",
        "erlang",
        "fennel",
        "forth",
        "haskell",
        "html",
        "javascript",
        "r",
        "json",
        "json5",
        "jsonc",
        "just",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "perl",
        "printf",
        "python",
        "query",
        "regex",
        "svelte",
        "toml",
        "tsv",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      -- incremental_selection = {
      --   enable = true,
      --   keymaps = {
      --     init_selection = "<C-i>",
      --     node_incremental = "<C-i>",
      --     scope_incremental = false,
      --     node_decremental = "<bs>",
      --   },
      -- },
      -- textobjects = {
      --   select = {
      --     enable = true,
      --     lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      --     keymaps = {
      --       -- You can use the capture groups defined in textobjects.scm
      --       ['aa'] = '@parameter.outer',
      --       ['ia'] = '@parameter.inner',
      --       ['af'] = '@function.outer',
      --       ['if'] = '@function.inner',
      --       ['ac'] = '@class.outer',
      --       ['ic'] = '@class.inner',
      --     },
      --   },
      -- },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   event = "VeryLazy",
  --   enabled = true,
  --   config = function()
  --     require("nvim-treesitter.configs").setup({ textobjects = {} })
  --   end,
  -- }

}
