return {
    'saghen/blink.cmp',

    dependencies = { 'rafamadriz/friendly-snippets' },

    version = '1.*',

    opts = {
        keymap = { preset = 'enter' },

        appearance = {
            nerd_font_variant = 'mono'
        },

        completion = {
            documentation = { auto_show = true },
            ghost_text = { enabled = true },
            menu = {
                draw = {
                    treesitter = { 'lsp' }
                }
            }
        },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            per_filetype = {
                rust = { 'lsp', 'path', 'snippets' },
            },
            providers = {
                lsp = { score_offset = 100 },
                snippets = { score_offset = -3 },
                buffer = { score_offset = -5, min_keyword_length = 4 },
            },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" }
    },

    opts_extend = { "sources.default" }
}
