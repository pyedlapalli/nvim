return {

    "nvim-tree/nvim-tree.lua",

    config = function()
        require('nvim-tree').setup({})
        vim.keymap.set("n", "<leader>nt",function() vim.cmd("NvimTreeToggle") end, { desc = "toggle nvim tree" })
        vim.keymap.set("n", "<leader>nf",function() vim.cmd("NvimTreeFocus") end, { desc = "focus nvim tree" })
    end
}
