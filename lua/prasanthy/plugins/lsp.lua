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

      -- shows LSP hover documentation for the symbol under the cursor
      -- in a vertical split on the right, instead of a floating window
      local function hover_in_split()
          local params = vim.lsp.util.make_position_params(0, 'utf-16')
          vim.lsp.buf_request(0, 'textDocument/hover', params, function(err, result)
              if err or not result or not result.contents then
                  vim.notify('No documentation available', vim.log.levels.INFO)
                  return
              end

              local lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
              if vim.tbl_isempty(lines) then
                  vim.notify('No documentation available', vim.log.levels.INFO)
                  return
              end

              vim.cmd('vertical rightbelow new')
              local doc_bufnr = vim.api.nvim_get_current_buf()
              vim.bo.buftype = 'nofile'
              vim.bo.bufhidden = 'wipe'
              vim.bo.swapfile = false
              -- fill content before attaching a filetype/parser so treesitter's
              -- markdown-injection queries don't run against an empty buffer
              vim.api.nvim_buf_set_lines(doc_bufnr, 0, -1, false, lines)
              vim.bo.modifiable = false
              vim.bo.filetype = 'markdown'
              -- markdown's fenced-code injection parser can crash on some
              -- nvim builds; fall back to legacy regex syntax highlighting
              pcall(vim.treesitter.stop, doc_bufnr)
              vim.bo.syntax = 'markdown'
          end)
      end

      local lsp_attach = function(_, bufnr)
          lsp_zero.default_keymaps({buffer = bufnr})
          vim.keymap.set('n', '<leader>k', hover_in_split, { buffer = bufnr, desc = 'Hover doc in split' })
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
          ensure_installed = {'lua_ls', 'clangd', 'rust_analyzer', 'jdtls', 'jsonls', 'gopls', 'zls'},
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
              clangd = function()
                  require('lspconfig').clangd.setup({
                      cmd = {
                          'clangd',
                          '--background-index',
                          '--clang-tidy',
                          '--completion-style=detailed',
                          '--header-insertion=iwyu',
                          '--all-scopes-completion',
                          '--function-arg-placeholders',
                          '--pch-storage=memory',
                      },
                  })
              end,
              zls = function()
                  require('lspconfig').zls.setup({
                      settings = {
                          zls = {
                              enable_snippets = true,
                              enable_argument_placeholders = true,
                              completion_label_details = true,
                              enable_inlay_hints = true,
                              inlay_hints_show_variable_type_hints = true,
                              inlay_hints_show_parameter_name = true,
                              warn_style = true,
                          },
                      },
                  })
              end,
              rust_analyzer = function()
                  require('lspconfig').rust_analyzer.setup({
                      -- sysroot (std) manifests use nightly-only cargo features; rust-analyzer's
                      -- own `cargo metadata` calls fail on stable cargo without this
                      cmd_env = { RUSTC_BOOTSTRAP = "1" },
                      settings = {
                          ["rust_analyzer"] = {
                              diagnostics = {
                                  disabled = { "unlinked-file" },
                              },
                              inlayHints = {
                                  typeHints = { enable = true },
                                  parameterHints = { enable = true },
                                  chainingHints = { enable = true },
                                  closingBraceHints = { enable = true },
                              },
                              lens = { enable = false },
                          },
                      },
                  })
              end
          }
      })
  end
}
