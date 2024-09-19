vim.g.mapleader = " "

---- Plugin keymaps ----

-- Open Lazy plugin manager
vim.keymap.set("n", "<leader>;", function()
    vim.cmd("Lazy")
end)

-- nvim tree
vim.keymap.set("n", "<leader>pv",function() vim.cmd("NvimTreeFocus") end, { desc = "focus nvim tree" })
vim.keymap.set("n", "<C-p>", vim.cmd("NvimTreeToggle"), { desc = "toggle nvim tree" })

-- neogit
vim.keymap.set("n", "<leader>ng", function()
    vim.cmd("Neogit")
end, { desc = "git plugin" })

-- telescope
vim.keymap.set("n", "<leader>pf", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
vim.keymap.set("n", "<leader>pw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
vim.keymap.set("n", "<leader>pb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
vim.keymap.set("n", "<leader>pm", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
vim.keymap.set("n", "<leader>pc", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
vim.keymap.set("n", "<leader>ps", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
vim.keymap.set("n", "<leader>th", "<cmd>Telescope colorscheme enable_preview=true<CR>", { desc = "telescope themes" })
vim.keymap.set(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)


---- Custom keymaps ----

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
end, { desc = "clear search highlight" })

--replace word that cursor is on
vim.keymap.set("n", "<leader>ra", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "replace current word in file" })

-- poeserve copied leader when pasting on highlighted word
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
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", 
    {
        desc = "make current file executable",
        silent = true 
    }
)
