local options = {
  formatters_by_ft = {
    lua = { "stylua" },

    python = { "isort", "black" },

    java = { "google-java-format" },

    c = { "clang-format" },
    cpp = { "clang-format" },

    rust = { "rustfmt" },
    go = { "goimports", "gofmt" },

    sh = { "shfmt" },
    bash = { "shfmt" },
    toml = { "taplo" },

    -- Web / config: prefer prettierd, fall back to prettier
    javascript = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    html = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier", stop_after_first = true },
    scss = { "prettierd", "prettier", stop_after_first = true },
    json = { "prettierd", "prettier", stop_after_first = true },
    jsonc = { "prettierd", "prettier", stop_after_first = true },
    yaml = { "prettierd", "prettier", stop_after_first = true },
    markdown = { "prettierd", "prettier", stop_after_first = true },
  },

  format_on_save = {
    timeout_ms = 700,
    lsp_format = "fallback",
  },
}

return options
