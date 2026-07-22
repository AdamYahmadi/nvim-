-- This file controls the NvChad look & feel.
-- Full list of options: https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  -- Switch themes live at any time with <leader>th (theme picker).
  -- Nice options: "jellybeans", "tokyonight", "onedark", "gruvchad",
  -- "rosepine", "kanagawa", "everforest", "nord", "poimandres".
  theme = "jellybeans",

  -- transparency = true,  -- uncomment for a transparent background

  -- Example override: make comments italic
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.ui = {
  -- Completion menu look. Options: "default", "flat_light", "flat_dark",
  -- "atom", "atom_colored".
  cmp = {
    style = "atom_colored",
  },

  statusline = {
    -- "default", "vscode", "vscode_colored", "minimal"
    theme = "vscode_colored",
    separator_style = "round",
  },

  -- Buffer/tab line at the top
  tabufline = {
    enabled = true,
    lazyload = true,
    order = { "treeOffset", "buffers", "tabs", "btns" },
  },
}

-- The pretty start screen
M.nvdash = {
  load_on_startup = true,
}

return M
