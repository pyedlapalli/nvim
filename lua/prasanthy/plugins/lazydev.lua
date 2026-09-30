return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- Only load when editing Lua files
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
