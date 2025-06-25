-- git plugin remap
vim.keymap.set("n", "<leader>ng", function() vim.cmd("Neogit") end, { desc = "git plugin" })

-- file tree remap
vim.keymap.set("n", "<leader>nf",function() vim.cmd("NvimTreeFocus") end, { desc = "focus nvim tree" })
vim.keymap.set("n", "<leader>nt",function() vim.cmd("NvimTreeToggle") end, { desc = "toggle nvim tree" })
