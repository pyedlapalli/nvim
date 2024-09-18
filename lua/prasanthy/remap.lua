vim.g.mapleader = " "

-- Open Lazy plugin manager
vim.keymap.set("n", "<leader>;", function()
    vim.cmd("Lazy")
end)

-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Project View" })
vim.keymap.set("n", "<leader>bb",function()
    vim.cmd("NvimTreeToggle")
end, { desc = "view nvim tree" })

vim.keymap.set("n", "<leader>pv", "<C-w>w", { desc = "toggle tree buffer" })

vim.keymap.set("n", "<leader>th", function()
    vim.cmd("Themery")
end, { desc = "switch theme" })

vim.keymap.set("n", "<leader>gs", function()
    vim.cmd("Neogit")
end, { desc = "git plugin" })

-- View project (either through standard :Ex or nvim tree)
-- make current file executable (for source)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", 
    {
        desc = "make current file executable",
        silent = true 
    }
)

-- source current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end, { desc = "source file" })

-- move blocks of code up/down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- center cursor on screen when doing half page up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- center cursor when navigating through search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- clear search highlight
vim.keymap.set("n", "<leader>n", function()
    vim.cmd("noh")
end)

-- preserve copied text when pasting on highlighted word
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "special reg paste" })

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

--replace word that cursor is on
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "replace current word" })

