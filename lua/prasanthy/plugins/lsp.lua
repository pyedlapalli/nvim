return {
  'VonHeikemen/lsp-zero.nvim',
  dependencies = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {'williamboman/mason.nvim'},           -- Optional
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},     -- Required
    {'hrsh7th/cmp-nvim-lsp'}, -- Required
    {'L3MON4D3/LuaSnip'},     -- Required
  },

  config = function ()

      --- LSP Setup ---
      local lsp_zero = require('lsp-zero')

      local lsp_attach = function(_, bufnr)
          lsp_zero.default_keymaps({buffer = bufnr})
      end

      lsp_zero.extend_lspconfig({
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
          lsp_attach = lsp_attach,
          float_border = 'rounded',
          sign_text = true,
      })

      --- Mason Setup ---
      require('mason').setup({})
      require('mason-lspconfig').setup({
          ensure_installed = {'lua_ls', 'rust_analyzer', 'jdtls'},
          handlers = {
              -- this first function is the "default handler"
              -- it applies to every language server without a "custom handler"
              function(server_name)
                  require('lspconfig')[server_name].setup({})
              end,

              -- this is the "custom handler" for `jdtls`
              -- noop is an empty function that doesn't do anything
              jdtls = lsp_zero.noop,
              lua_ls = function()
                  require('lspconfig').lua_ls.setup({
                      on_init = function(client)
                          lsp_zero.nvim_lua_settings(client, {})
                      end,
                  })
              end,
          }
      })

      --- Completion setup ---
      local cmp = require('cmp')
      local cmp_format = require('lsp-zero').cmp_format()

      cmp.setup({
          sources = {
              {name = 'nvim_lsp'},
          },
          mapping = cmp.mapping.preset.insert({
              -- scroll up and down the documentation window
              ['<C-u>'] = cmp.mapping.scroll_docs(-4),
              ['<C-d>'] = cmp.mapping.scroll_docs(4),
          }),
          formatting = cmp_format,
          snippet = {
              expand = function(args)
                  require('luasnip').lsp_expand(args.body)
              end,
          },
      })
  end
}
