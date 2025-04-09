require "nvchad.options"

vim.cmd([[ hi Normal guibg=NONE ctermbg=NONE ]])
vim.cmd([[ hi NormalNC guibg=NONE ctermbg=NONE ]])
vim.cmd([[ hi EndOfBuffer guibg=NONE ctermbg=NONE ]])
vim.cmd([[ hi SignColumn guibg=NONE ctermbg=NONE ]])
vim.cmd([[ hi LineNr guibg=NONE ctermbg=NONE ]])


-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
--
--
--
local opt = vim.opt

-- Tabs & indentation
opt.tabstop = 4         -- 1 tab = 4 spaces
opt.shiftwidth = 4      -- indent width
opt.expandtab = true    -- use spaces instead of tabs
opt.autoindent = true   -- copy indent from current line
opt.smartindent = true  -- smart autoindent

