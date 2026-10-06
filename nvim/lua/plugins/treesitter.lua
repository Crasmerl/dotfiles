return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "python", "lua", "javascript", "typescript", "tsx",
        "html", "css", "c", "cpp", "c_sharp",
        "json", "yaml", "toml", "bash", "markdown",
        "vim", "vimdoc", "regex", "query",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}

