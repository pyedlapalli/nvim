vim.g.mapleader = " "

-- Open Lazy plugin manager
vim.keymap.set("n", "<leader>;l", function() vim.cmd("Lazy") end, { desc = "open lazy plugin manager" })
vim.keymap.set("n", "<leader>;m", function() vim.cmd("Mason") end, { desc = "open mason lsp manager" })

-- source current fil
vim.keymap.set("n", "<leader><leader>", function() vim.cmd("so") end, { desc = "source file" })

-- move blocks of code up/down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- always center cursor when scrolling
vim.keymap.set({"n", "v"}, "j", "jzz")
vim.keymap.set({"n", "v"}, "k", "kzz")

-- center cursor on screen when doing half page up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- center cursor when navigating through search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- clear search highlight
vim.keymap.set("n", "<leader>h", function() vim.cmd("noh") end, { desc = "clear search highlight" })

--replace word that cursor is on
vim.keymap.set("n", "<leader>ra", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "replace current word in file" })

-- preserve copied leader when pasting on highlighted word
vim.keymap.set("v", "<leader>p", [["_dP]], { desc = "special reg paste" })

-- paste into system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "paste to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "paste to clipboard" })

-- delete to void register to avoid overwriting clipboard
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]], { desc = "special delete" })

-- quick fix centering behavior
vim.keymap.set("n", "<Cd-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- make current file executable (for source)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "make current file executable", silent = true })
