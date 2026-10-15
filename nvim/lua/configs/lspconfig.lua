require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html", "cssls",
  "pyright",
  "lua_ls",
  "ts_ls",
  "clangd",
  "csharp_ls",
  "jsonls",
  "bashls",
}
vim.lsp.enable(servers)
