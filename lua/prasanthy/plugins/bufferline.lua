return{

    'romgrk/barbar.nvim',

    dependencies = {
        'lewis6991/gitsigns.nvim',
        'nvim-tree/nvim-web-devicons',
    },

    init = function() vim.g.barbar_auto_setup = false end,

    opts = {},

    version = '^1.0.0', 

    config = function()
        require('barbar').setup({
            sidebar_filetypes = {
                -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
                NvimTree = true,
                -- Or, specify the text used for the offset:
                undotree = {
                    text = 'undotree',
                    align = 'center', -- *optionally* specify an alignment (either 'left', 'center', or 'right')
                },
            }
        })

        vim.keymap.set("n", "<leader>bp", "<cmd>bprev<CR>", { desc = "prev buffer" })
        vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "next buffer" })
        vim.keymap.set("n", "<leader>bec", function() vim.cmd("bdelete") vim.cmd("bnext") end, { desc = "erase curr buffer" })
        vim.keymap.set("n", "<leader>ber", "<cmd>%bdelete<CR>", { desc = "erase all buffers" })
    end
}

