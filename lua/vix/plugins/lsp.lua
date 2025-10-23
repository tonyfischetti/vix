--  TODO  READ! https://github.com/neovim/nvim-lspconfig
--  TODO  http://www.lazyvim.org/plugins/lsp

--  TODO  what are "code actions"? should I use telescope with them?


return {

  {
    "williamboman/mason.nvim",
    lazy = false,
    config=true
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim"
    },
    opts = {
      --  TODO  I'm pretty sure I don't want it to auto install
      --        the haskell one doesn't work
      ensure_installed = {
        -- "r_language_server",
        "clangd",
        "ts_ls",
        "lua_ls",
      }
    }
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },

    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      ---------------------------------------
      --      r_language_server setup      --
      ---------------------------------------
      vim.lsp.config("r_language_server", {
        -- cmd = {"R", "--slave", "-e", "languageserver::run()"},
        capabilities = capabilities,
      })

      --------------------------------------
      --       clangd c++ lsp setup       --
      --------------------------------------
      vim.lsp.config("clangd", {
        capabilities = capabilities,
      })


      -------------------------------
      --       denols config       --
      -------------------------------
      -- vim.lsp.config("denols", {
      --   root_dir = function(fname)
      --     -- prefer deno projects without package.json
      --     local has_pkg = vim.fs.find({ "package.json" }, { path = vim.fs.dirname(fname), upward = true })[1]
      --     if has_pkg then return nil end
      --     local deno_json = vim.fs.find({ "deno.json", "deno.jsonc" }, { path = vim.fs.dirname(fname), upward = true })[1]
      --     return deno_json and vim.fs.dirname(deno_json) or vim.uv.cwd()
      --   end,
      --   capabilities = capabilities,
      -- })


      -------------------------------
      --      tsserver config      --
      -------------------------------
      vim.lsp.config("ts_ls", {
        single_file_support = true,
        capabilities = capabilities,
        -- on_init = function(client)
        --   client.server_capabilities.semanticTokensProvider = nil
        -- end,
      })


      ------------------------------
      --      lua lsp config      --
      ------------------------------
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim", "opts" } },
            workspace = { checkThirdParty = false },
            codeLens = { enable = true },
            completion = { callSnippet = "Replace" },
            doc = { privateName = { "^_" } },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = "Disable",
              semicolon = "Disable",
              arrayIndex = "Disable",
            },
          },
        },
      })


      -------------------------------------
      --             haskell             --
      -------------------------------------
      vim.lsp.config("hls", {
        capabilities = capabilities,
      })


      -----------------------------
      --         keymaps         --
      -----------------------------

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf
          local map = function(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf })
          end
          map("n", "gd", vim.lsp.buf.definition)
          map("n", "gD", vim.lsp.buf.declaration)
          map("n", "gi", vim.lsp.buf.implementation)
          map("n", "gr", vim.lsp.buf.references)
          map("n", "<C-k>", vim.lsp.buf.signature_help)
          map("n", "<Space>2d", vim.lsp.buf.definition)
          map("n", "<Space>2D", vim.lsp.buf.declaration)
          map("n", "<Space>2i", vim.lsp.buf.implementation)
          map("n", "<Space>2s", vim.lsp.buf.signature_help)
          map("n", "<Space>2t", vim.lsp.buf.type_definition)
          map("n", "<Space>mv", vim.lsp.buf.rename)
          map("n", "<Space>2p", function() vim.lsp.buf.format({ async = true }) end)
          map("n", "<Space>2r", vim.lsp.buf.references)
          map({ "n", "v" }, "<Space>ca", vim.lsp.buf.code_action)
        end,
      })

    end
  },

}

