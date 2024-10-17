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
        "r_language_server",
        "clangd",
        "ts_ls",
        "lua_ls",
        "denols"
      }
    }
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },

    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      ---------------------------------------
      --      r_language_server setup      --
      ---------------------------------------
      lspconfig.r_language_server.setup({
        -- cmd = {"R", "--slave", "-e", "'languageserver::run()'"}
        -- TODO  can I use `on_attach` for other things
        -- on_attach = on_attach_custom
      })

      --------------------------------------
      --       clangd c++ lsp setup       --
      --------------------------------------
      lspconfig.clangd.setup({
      })


      -------------------------------
      --       denols config       --
      -------------------------------
      lspconfig.denols.setup {
        -- single_file_support = true,
        root_dir = function(fn)
          if lspconfig.util.root_pattern("package.json")(fn) then
            return nil;
          end
          local has_deno_json = lspconfig.util.root_pattern("deno.json")(fn);
          if has_deno_json then
            return has_deno_json
          end
          return "."
        end
      }


      -------------------------------
      --      tsserver config      --
      -------------------------------
      lspconfig.tsserver.setup({
        root_dir = require("lspconfig").util.root_pattern("package.json"),
        single_file_support = false,
        capabilities = capabilities,
        -- on_attach = function(client)
        --   -- client.server_capabilities.semanticTokensProvider = nil
        --   -- client.server_capabilities.documentFormattingProvider = nil
        --   -- client.server_capabilities.documentFormattingRangeProvider = nil
        -- end,
        -- init_options = {
        --   preferences = {
        --     disableSuggestions = true
        --   }
        -- }
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
            diagnostics = { globals = { 'vim', 'opts' } },
            workSpace = {
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

      -------------------------------------
      --             haskell             --
      -------------------------------------
      lspconfig.hls.setup({
      })

      -----------------------------
      --         keymaps         --
      -----------------------------
      -- TODO
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      -- handled by Fildo7525/pretty_hover now
      -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<Space>2d', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', '<Space>2D', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', '<Space>2i', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<Space>2s', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<Space>2t', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<Space>mv', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<Space>2p', function() vim.lsp.buf.format { async = true } end)
      vim.keymap.set('n', '<Space>2r', vim.lsp.buf.references, opts)
      vim.keymap.set({ 'n', 'v' }, '<Space>ca', vim.lsp.buf.code_action, opts)

      --  TODO: what's this
      -- vim.keymap.set('n', '<Space>wa', vim.lsp.buf.add_workspace_folder, opts)
      -- vim.keymap.set('n', '<Space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      -- vim.keymap.set('n', '<Space>wl', function()
      --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      -- end, opts)
    end
  },

}

