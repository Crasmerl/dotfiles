require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- guardar
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })

-- formatear manualmente
map("n", "<leader>fm", function()
  require("conform").format { async = true }
end, { desc = "Format file" })

-- navegar diagnósticos LSP
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostic list" })

-- telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>",              { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>",               { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>",                 { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>",               { desc = "Help tags" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>",                { desc = "Recent files" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>",             { desc = "Diagnostics" })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>",    { desc = "Symbols" })
