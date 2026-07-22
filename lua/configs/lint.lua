local lint = require "lint"

-- Note: Python linting is already handled by the ruff LSP, so it is not
-- duplicated here. These cover tools without a good LSP-based linter.
lint.linters_by_ft = {
  sh = { "shellcheck" },
  bash = { "shellcheck" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  cpp = { "cpplint" },
  c = { "cpplint" },
}

local group = vim.api.nvim_create_augroup("nvim_lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = group,
  callback = function()
    -- Only run if a linter exists for this filetype
    local ft = vim.bo.filetype
    if lint.linters_by_ft[ft] then
      lint.try_lint()
    end
  end,
})
