
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end


return {

  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp"
  },

  {
    "hrsh7th/nvim-cmp",
    -- TODO: all of these have options... look into them
    --       and nvim-cmp, in general
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-path" },
      { "L3MON4D3/LuaSnip" },
      { "saadparwaiz1/cmp_luasnip" },
      { "neovim/nvim-lspconfig" },
      { "hrsh7th/cmp-omni" },
    },
    config = function()
      -- Set up nvim-cmp.
      local cmp = require('cmp')
      require("luasnip.loaders.from_snipmate").lazy_load()

      -----------------------------------
      --       cmp configuration       --
      -----------------------------------
      cmp.setup({

        -- TODO: ???
        completion = {
          autocomplete = false
        },

        -- TODO: how do I prioritize?!
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'omni' },
          {
            name = 'buffer',
            option = {
              keyword_pattern = [[\k\+]],
            }
          },
          { name = 'path' },
          { name = 'luasnip' },
        }),

        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        --
        -- TODO: play with this
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-e>'] = cmp.mapping.abort(),

          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false
          },


          -- if autocomplete = false
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if #cmp.get_entries() == 1 then
                cmp.confirm({ select = true })
              else
                cmp.select_next_item()
              end
            elseif has_words_before() then
              cmp.complete()
              if #cmp.get_entries() == 1 then
                cmp.confirm({ select = true })
              -- else
              --   cmp.select_next_item()
              end
            else
              fallback()
            end
          end, { "i", "s" }),


          -- if autocomplete = true
          -- ['<Tab>'] = cmp.mapping(function(fallback)
          --   if cmp.visible() then
          --     cmp.select_next_item()
          --   -- elseif luasnip.expand_or_jumpable() then
          --   --   luasnip.expand_or_jump()
          --   else
          --     fallback()
          --   end
          -- end, { 'i', 's' }),
          --
          -- ['<S-Tab>'] = cmp.mapping(function(fallback)
          --   if cmp.visible() then
          --     cmp.select_prev_item()
          --   -- elseif luasnip.jumpable(-1) then
          --   --   luasnip.jump(-1)
          --   else
          --     fallback()
          --   end
          -- end, { 'i', 's' })

        })

      })

      --   -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
      --   -- Set configuration for specific filetype.
      --   --[[ cmp.setup.filetype('gitcommit', {
      --   sources = cmp.config.sources({
      --   { name = 'git' },
      --   }, {
      --   { name = 'buffer' },
      --   })
      --   })
      --   require("cmp_git").setup() ]]--
      --
      --   -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      --   cmp.setup.cmdline({ '/', '?' }, {
      --     mapping = cmp.mapping.preset.cmdline(),
      --     sources = {
      --       { name = 'buffer' }
      --     }
      --   })
      --
      --   -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      --   cmp.setup.cmdline(':', {
      --     mapping = cmp.mapping.preset.cmdline(),
      --     sources = cmp.config.sources({
      --       { name = 'path' }
      --     }, {
      --       { name = 'cmdline' }
      --     }),
      --     matching = { disallow_symbol_nonprefix_matching = false }
      --   })
      --
      -- Set up lspconfig.
      -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
      -- require('lspconfig')['tsserver'].setup {
      --   capabilities = capabilities
      -- }
    end
  },

}
