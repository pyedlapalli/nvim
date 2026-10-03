local function collapse_node()
    local api = require("nvim-tree.api")
    local node = api.tree.get_node_under_cursor()
    if node ~= nil then
       api.node.collapse()
    end
end

-- on_attach
vim.keymap.set("n", "<C-P>", collapse_node, nil)
