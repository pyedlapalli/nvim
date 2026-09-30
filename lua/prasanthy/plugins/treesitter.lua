return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function ()
      local ensure_installed = { "c", "cpp", "cmake", "make", "lua", "vim", "vimdoc", "markdown", "query", "javascript", "html", "java", "python", "ruby", "xml", "yaml", "zig" }

      require("nvim-treesitter").install(ensure_installed)

      local filetypes = vim.deepcopy(ensure_installed)
      table.insert(filetypes, "help") -- vimdoc parser attaches to the help filetype

      vim.api.nvim_create_autocmd("FileType", {
        pattern = filetypes,
        callback = function ()
          vim.treesitter.start()
        end,
      })
    end
}
