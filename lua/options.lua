require "nvchad.options"

-- Extra options on top of NvChad defaults --------------------------------
local o = vim.o
local opt = vim.opt

-- Line numbers
o.number = true
o.relativenumber = true

-- Indentation (4 spaces is a sane default for Python/Java/C/C++)
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true

-- Search
o.ignorecase = true
o.smartcase = true

-- UI / editing quality of life
o.wrap = false
o.scrolloff = 8
o.sidescrolloff = 8
o.cursorline = true
o.signcolumn = "yes"
o.termguicolors = true
o.updatetime = 250
o.timeoutlen = 400
o.undofile = true
opt.completeopt = { "menu", "menuone", "noselect" }

-- Split behaviour
o.splitright = true
o.splitbelow = true

-- Nice list chars
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Per-language tweaks: 2-space indent for web / config files
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "javascript", "typescript", "javascriptreact", "typescriptreact",
    "json", "jsonc", "yaml", "html", "css", "scss", "lua", "markdown",
  },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
  end,
})
