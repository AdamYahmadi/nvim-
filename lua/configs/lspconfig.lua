-- Loads NvChad's default LSP settings (on_attach, capabilities, lua_ls, etc.)
require("nvchad.configs.lspconfig").defaults()

local capabilities = require("nvchad.configs.lspconfig").capabilities

-- Attach nvim-navic to LSP clients so breadcrumbs (barbecue) work ---------
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.server_capabilities.documentSymbolProvider then
      local ok, navic = pcall(require, "nvim-navic")
      if ok then
        navic.attach(client, args.buf)
      end
    end
  end,
})

-- Servers that just need the defaults -------------------------------------
local servers = {
  "pyright", -- Python (types)
  "ruff", -- Python (lint/format LSP)
  "clangd", -- C / C++
  "cmake", -- CMake
  "lua_ls", -- Lua (already enabled by defaults, harmless to repeat)
  "ts_ls", -- JavaScript / TypeScript
  "html",
  "cssls",
  "jsonls",
  "yamlls",
  "bashls",
  "rust_analyzer",
  "gopls",
  "marksman", -- Markdown
  "dockerls",
  "taplo", -- TOML
  -- NOTE: Java (jdtls) is intentionally NOT here. It is started per-buffer
  -- by nvim-jdtls from ftplugin/java.lua.
}

-- Per-server tweaks (must be registered before enabling) ------------------
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  },
})

vim.lsp.config("pyright", {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
})

-- Let ruff handle lint/format only; let pyright own hover/definitions.
vim.lsp.config("ruff", {
  on_attach = function(client, _)
    client.server_capabilities.hoverProvider = false
  end,
})

-- Apply shared capabilities to everything, then enable.
vim.lsp.config("*", { capabilities = capabilities })
vim.lsp.enable(servers)
