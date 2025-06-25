-- buffer window remaps 
vim.keymap.set("n", "<leader>bf", function() vim.cmd("BufferNext") end, { desc = "next buffer" })
vim.keymap.set("n", "<leader>bb", function() vim.cmd("BufferPrevious") end, { desc = "prev buffer" })
vim.keymap.set("n", "<leader>bec", function() vim.cmd("BufferClose") end, { desc = "close curr buffer" })
vim.keymap.set("n", "<leader>bea", function() vim.cmd("BufferCloseAllButPinned") end, { desc = "close all buffers" })
