local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    java = { "checkstyle" },  -- Java formatting with Checkstyle
    python = { "black" },     -- Python formatting with Black
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  format_on_save = {
    -- Enable format on save
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options

