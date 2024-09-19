return {
    "nvim-telescope/telescope.nvim",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope')

        vim.keymap.set("n", "<leader>pf", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
        vim.keymap.set("n", "<leader>pw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
        vim.keymap.set("n", "<leader>pb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
        vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
        vim.keymap.set("n", "<leader>pm", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
        vim.keymap.set("n", "<leader>pc", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
        vim.keymap.set("n", "<leader>ps", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
        vim.keymap.set("n", "<leader>th", "<cmd>Telescope colorscheme enable_preview=true<CR>", { desc = "telescope themes" })
        vim.keymap.set(
        "n",
        "<leader>fa",
        "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
        { desc = "telescope find all files" }
        )

    end
}
