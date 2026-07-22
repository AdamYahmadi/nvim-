require "nvchad.mappings"

local map = vim.keymap.set

-- General ----------------------------------------------------------------
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlight" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })

-- Move selected lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- LSP (these complement NvChad's built-in gd / gD / <leader>ra) -----------
map("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "LSP implementation" })
map("n", "gr", vim.lsp.buf.references, { desc = "LSP references" })
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "LSP signature help" })

-- Diagnostics (Neovim 0.11 jump API) -------------------------------------
map("n", "[d", function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = "Prev diagnostic" })
map("n", "]d", function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = "Next diagnostic" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- Formatting -------------------------------------------------------------
map({ "n", "v" }, "<leader>fm", function()
  require("conform").format { async = true, lsp_format = "fallback" }
end, { desc = "Format file/selection" })

-- Trouble (diagnostics / symbols list) -----------------------------------
map("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Trouble diagnostics" })
map("n", "<leader>tb", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Trouble buffer diagnostics" })
map("n", "<leader>ts", "<cmd>Trouble symbols toggle focus=false<CR>", { desc = "Trouble symbols" })
map("n", "<leader>tl", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", { desc = "Trouble LSP refs/defs" })
map("n", "<leader>tq", "<cmd>Trouble qflist toggle<CR>", { desc = "Trouble quickfix" })

-- Debugging (nvim-dap) ---------------------------------------------------
map("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "DAP toggle UI" })
map("n", "<leader>de", function()
  require("dapui").eval(nil, { enter = true })
end, { desc = "DAP eval expression" })

-- Java-specific extras are set inside ftplugin/java.lua when a .java file opens.
