return {
  "neovim/nvim-lspconfig",
  config = function()
    -- En Nvim 0.11+, habilitas el server así:
    vim.lsp.enable("pyright")

    -- (Opcional) si quieres personalizar cosas del server:
    -- vim.lsp.config("pyright", {
    --   settings = {
    --     python = {
    --       analysis = { typeCheckingMode = "basic" },
    --     },
    --   },
    -- })
  end,
}

--vim.lsp.enable("ruff")
