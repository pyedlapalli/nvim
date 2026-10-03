return {
  'VonHeikemen/lsp-zero.nvim',
  dependencies = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {'williamboman/mason.nvim'},           -- Optional
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    'saghen/blink.cmp'
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

      -- mimics VSCode's cmd+click: jump to the definition, or if the cursor
      -- is already on the definition, show references instead
      local function definition_or_references()
          local params = vim.lsp.util.make_position_params(0, 'utf-16')
          vim.lsp.buf_request_all(0, 'textDocument/definition', params, function(results)
              local cur_uri = vim.uri_from_bufnr(0)
              local cur = vim.api.nvim_win_get_cursor(0)
              local cur_line, cur_col = cur[1] - 1, cur[2]

              for _, res in pairs(results) do
                  local locs = res.result
                  if locs and not vim.islist(locs) then locs = { locs } end
                  for _, loc in ipairs(locs or {}) do
                      local uri = loc.uri or loc.targetUri
                      local range = loc.range or loc.targetSelectionRange
                      local s, e = range.start, range['end']
                      local on_def = uri == cur_uri
                          and (cur_line > s.line or (cur_line == s.line and cur_col >= s.character))
                          and (cur_line < e.line or (cur_line == e.line and cur_col <= e.character))
                      if on_def then
                          require('telescope.builtin').lsp_references({ include_declaration = false })
                          return
                      end
                  end
              end
              vim.lsp.buf.definition()
          end)
      end

      local lsp_attach = function(client, bufnr)
          lsp_zero.default_keymaps({buffer = bufnr})
          vim.keymap.set('n', '<leader>k', function() vim.lsp.buf.hover({ border = 'rounded' }) end, { buffer = bufnr, desc = 'Hover doc in popup' })
          vim.keymap.set('n', '<leader>K', hover_in_split, { buffer = bufnr, desc = 'Hover doc in split' })
          vim.keymap.set('n', 'gd', definition_or_references, { buffer = bufnr, desc = 'Definition, or references if on definition' })
          vim.keymap.set('n', 'gi', function() require('telescope.builtin').lsp_implementations() end, { buffer = bufnr, desc = 'Implementations' })
          vim.keymap.set('n', '<leader>ih', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
          end, { buffer = bufnr, desc = 'Toggle inlay hints' })

          -- inline type / parameter-name hints (the grey `: Vec2` annotations)
          if client and client:supports_method('textDocument/inlayHint') then
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
          -- code lens is intentionally not enabled for any server
      end

      lsp_zero.extend_lspconfig({
          capabilities = require('blink.cmp').get_lsp_capabilities(),
          lsp_attach = lsp_attach,
          float_border = 'rounded',
          sign_text = true,
      })

      lsp_zero.setup()

      --- LSP status messages in the command line ---
      -- single-line, truncated to the window width so it never triggers
      -- the "Press ENTER" prompt
      local function status(msg)
          local max = vim.o.columns - 12
          if #msg > max then msg = msg:sub(1, max - 3) .. '...' end
          vim.api.nvim_echo({ { msg } }, false, {})
          vim.cmd('redraw')
      end

      vim.api.nvim_create_autocmd('FileType', {
          pattern = { 'rust', 'lua', 'c', 'cpp', 'go', 'zig', 'json' },
          callback = function(ev)
              if #vim.lsp.get_clients({ bufnr = ev.buf }) == 0 then
                  status('LSP: starting...')
              end
          end,
      })

      vim.api.nvim_create_autocmd('LspAttach', {
          callback = function(ev)
              local client = vim.lsp.get_client_by_id(ev.data.client_id)
              if client then status('LSP: ' .. client.name .. ' attached, indexing...') end
          end,
      })

      vim.api.nvim_create_autocmd('LspProgress', {
          callback = function(ev)
              local client = vim.lsp.get_client_by_id(ev.data.client_id)
              local value = ev.data.params.value
              if not client or not value then return end
              if value.kind == 'end' then
                  status('LSP: ' .. client.name .. ' ready')
                  return
              end
              -- value.message is often a long file path, so only show the
              -- title and progress (percentage, or the "62/394" counter)
              local progress = value.percentage and (value.percentage .. '%')
                  or (value.message and value.message:match('^%d+/%d+'))
              local parts = { 'LSP: ' .. client.name, value.title, progress }
              status(table.concat(vim.tbl_filter(function(p) return p and p ~= '' end, parts), ' - '))
          end,
      })

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
