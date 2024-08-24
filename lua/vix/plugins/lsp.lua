-- TODO: READ! https://github.com/neovim/nvim-lspconfig

-- TODO: what are "code actions"? should I use telescope with them?

return {

  {
    "williamboman/mason.nvim",
    config = true
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "tsserver", "r_language_server" }
    }
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim"
    },

    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      ---------------------------------------
      --      r_language_server setup      --
      ---------------------------------------
      lspconfig.r_language_server.setup({
        -- cmd = {"R", "--slave", "-e", "'languageserver::run()'"}
        -- on_attach = on_attach_custom
      })

      -------------------------------
      --      tsserver config      --
      -------------------------------
      lspconfig.tsserver.setup({
        capabilities = capabilities,
        on_attach = function(client)
          print("hello tsserver")
          -- client.server_capabilities.semanticTokensProvider = nil
          -- client.server_capabilities.documentFormattingProvider = nil
          -- client.server_capabilities.documentFormattingRangeProvider = nil
        end
      })

      ------------------------------
      --      lua lsp config      --
      ------------------------------
      -- TODO
      -- lspconfig.lua_ls.setup(lua_ls_setup)
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {globals = { 'vim', 'opts' }},
            workspace = {
              checkThirdParty = false,
            },
            codeLens = {
              enable = true,
            },
            completion = {
              callSnippet = "Replace",
            },
            doc = {
              privateName = { "^_" },
            },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = "Disable",
              semicolon = "Disable",
              arrayIndex = "Disable",
            }
          }
        }
      })


      -----------------------------
      --         keymaps         --
      -----------------------------
      -- TODO
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
      end)
    end
  },

}

