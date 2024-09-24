return {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({})
    end

    -- Notes for keymaps --
    -- add: ys{motion}{char}
    -- delete: ds{char}
    -- change: cs{target}{replacement}
}
