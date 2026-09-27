return {
  'VonHeikemen/lsp-zero.nvim',
  dependencies = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {'williamboman/mason.nvim'},           -- Optional
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    'saghen/blink.cmp',
  },

  config = function ()

      --- LSP Setup ---
      local lsp_zero = require('lsp-zero')

      local lsp_attach = function(_, bufnr)
          lsp_zero.default_keymaps({buffer = bufnr})
      end

      lsp_zero.extend_lspconfig({
          capabilities = require('blink.cmp').get_lsp_capabilities(),
          lsp_attach = lsp_attach,
          float_border = 'rounded',
          sign_text = true,
      })

      lsp_zero.setup()

      vim.diagnostic.config({
          signs = true,
          update_in_insert = false,
          underline = true,
          severity_sort = false,
          float = true,
          virtual_text = true,
      })

      --- Mason Setup ---
      require('mason').setup({})
      require('mason-lspconfig').setup({
          ensure_installed = {'lua_ls', 'clangd', 'rust_analyzer', 'jdtls', 'jsonls', 'gopls'},
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
              end
          }
      })
  end
}
