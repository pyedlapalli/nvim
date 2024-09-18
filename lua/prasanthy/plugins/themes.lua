return {

    -- THEME SWITCHER --

    {
        "zaldih/themery.nvim",

        config = function()
            require('themery').setup({
                themes = { "cyberdream", "miasma" }, -- Your list of installed colorschemes.
                livePreview = true, -- Apply theme while picking. Default to true.
            })
        end
    },



    -- THEMES --
    
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
    },

    {
        "xero/miasma.nvim",
        lazy = false,
        priority = 1000,
    },
}
