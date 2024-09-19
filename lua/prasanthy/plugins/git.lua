return {

  "NeogitOrg/neogit",
  
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
    "ibhagwan/fzf-lua",              -- optional
    "echasnovski/mini.pick",         -- optional
  },
  
  config = function()
      require('neogit').setup()
      vim.keymap.set("n", "<leader>ng", function() vim.cmd("Neogit") end, { desc = "git plugin" })
  end

}
