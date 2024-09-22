return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "c", "cpp", "cmake", "make", "lua", "vim", "vimdoc", "markdown", "query", "javascript", "html", "java", "python", "ruby", "xml", "yaml" },
          sync_install = false,
          highlight = { enable = true },
        })
    end
}
