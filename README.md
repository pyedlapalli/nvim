# Neovim Config

Personal Neovim configuration written in Lua, using [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management. 

## Installation

Requires a recent Neovim (0.11+; the config uses `vim.lsp` APIs such as `vim.lsp.inlay_hint` and `client:supports_method`) and `git`.

```sh
git clone <this-repo> ~/.config/nvim
nvim
```

On first launch lazy.nvim bootstraps itself and installs all plugins. Mason installs the language servers listed below, and Treesitter installs its parsers.

## Structure

```
init.lua                      # disables netrw, enables termguicolors, loads prasanthy
lua/prasanthy/
  init.lua                    # loads remaps, options, lazy, colorscheme
  options.lua                 # editor options (relative numbers, 4-space indent, ...)
  lazy.lua                    # lazy.nvim bootstrap; specs come from plugins/
  plugins/                    # one spec file per plugin/feature
  remap/                      # keymaps, grouped by area
PluginList.txt                # plugins of interest
TODO.md
```

## Plugins

| Area | Plugin |
| --- | --- |
| Plugin manager | lazy.nvim |
| LSP | nvim-lspconfig, lsp-zero.nvim, mason.nvim, lazydev.nvim (Lua dev) |
| Completion | blink.cmp |
| Syntax | nvim-treesitter |
| Fuzzy finding | telescope.nvim |
| File tree | nvim-tree.lua |
| Git | neogit, diffview.nvim, gitsigns.nvim |
| UI | lualine.nvim, barbar.nvim (buffer tabs), which-key.nvim, nvim-web-devicons |
| Editing | nvim-autopairs, Comment.nvim, nvim-surround |
| Practice | vim-be-good |
| Themes | tokyonight (active), catppuccin, rose-pine, nightfox, everforest, onedark, dracula, nord, cyberdream, miasma, aurora |

### Language servers

`lua_ls`, `clangd`, `rust_analyzer`, `jdtls`, `jsonls`, `gopls`, `zls`

Inlay hints are enabled when the server supports them.

## Keybindings

Leader is `<Space>`. Press the leader and wait to see which-key hints.

### General

| Key | Action |
| --- | --- |
| `<leader><leader>` | Source current Lua/Vim file |
| `J` / `K` (visual) | Move selected block down / up |
| `j` / `k`, `<C-d>` / `<C-u>`, `n` / `N` | Movement that keeps the cursor centered |
| `<leader>h` | Clear search highlight |
| `<leader>ra` | Replace word under cursor in file |
| `<leader>p` (visual) | Paste without overwriting the register |
| `<leader>y` / `<leader>Y` | Yank to system clipboard |
| `<leader>d` | Delete to the void register |
| `<C-j>` | Previous quickfix item |
| `<leader>x` | `chmod +x` current file |
| `<leader>=` | Reindent whole file, keeping cursor position |

### Plugins and tools

| Key | Action |
| --- | --- |
| `<leader>;l` / `<leader>;m` | Open Lazy / Mason |
| `<leader>nt` / `<leader>nf` | Toggle / focus nvim-tree |
| `<C-P>` | Collapse node under cursor in nvim-tree |
| `<leader>ng` | Open Neogit |
| `<leader>bf` / `<leader>bb` | Next / previous buffer |
| `<leader>bec` / `<leader>bea` | Close current buffer / all but pinned |

### Telescope

| Key | Action |
| --- | --- |
| `<leader>pf` | Find files |
| `<leader>fa` | Find all files (hidden, ignored, symlinks) |
| `<leader>pw` | Live grep |
| `<leader>pb` | Buffers |
| `<leader>pm` | Marks |
| `<leader>pc` / `<leader>ps` | Git commits / status |
| `<leader>fh` | Help tags |
| `<leader>th` | Colorschemes with preview |

### LSP (buffers with an attached server)

lsp-zero's default keymaps, plus:

| Key | Action |
| --- | --- |
| `<leader>k` | Hover documentation in a popup |
| `<leader>K` | Hover documentation in a split on the right |
| `gd` | Go to definition (references if already on the definition) |
| `gi` | Implementations (Telescope) |
| `<leader>ih` | Toggle inlay hints |
