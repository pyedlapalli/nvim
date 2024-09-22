return {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({})
    end

    -- Notes for keymaps --
    -- add, delete, change
    -- ys{motion}{char}, ds{char}, and cs{target}{replacement}
}
