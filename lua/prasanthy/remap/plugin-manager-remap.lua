-- Open Lazy plugin manager
vim.keymap.set("n", "<leader>;m", function() vim.cmd("Mason") end, { desc = "open mason lsp manager" })
vim.keymap.set("n", "<leader>;l", function() vim.cmd("Lazy") end, { desc = "open lazy plugin manager" })
