-- Load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- List of servers with default config
local servers = { "html", "cssls", "clangd", "pyright"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Configure jdtls (Java LSP) with auto-formatting
lspconfig.jdtls.setup {
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)

    -- Enable formatting on save
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { async = false }
        end,
      })
    end
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = { "jdtls" }, -- Ensure jdtls is in your PATH
  root_dir = lspconfig.util.root_pattern("pom.xml", "build.gradle", ".git"),
}





