return {

    "nvim-tree/nvim-tree.lua",

    config = function()
        require('nvim-tree').setup({
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },
        })

        vim.api.nvim_create_user_command("NvimTreeDotfiles", function()
            require('nvim-tree').setup({
                filters = {
                    custom = { "^[^.]" }, -- exclude anything not starting with "."
                },
            })
            require('nvim-tree.api').tree.open()
        end, { desc = "Open nvim-tree showing only dotfiles/dotfolders" })
    end
}
