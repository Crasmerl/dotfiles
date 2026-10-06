local options = {
  formatters_by_ft = {
    python = { "ruff_format" },
    -- lua = { "stylua" }, -- instalar con: paru -S stylua
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
