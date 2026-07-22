local dap = require "dap"
local dapui = require "dapui"

-- UI + inline virtual text -----------------------------------------------
dapui.setup()
require("nvim-dap-virtual-text").setup {}

-- Auto open/close the debugger UI
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Nicer breakpoint signs
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticWarn", linehl = "Visual", numhl = "" })

-- C / C++ via codelldb (installed by Mason) ------------------------------
local mason = vim.fn.stdpath "data" .. "/mason"
local codelldb = mason .. "/packages/codelldb/extension/adapter/codelldb"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldb,
    args = { "--port", "${port}" },
  },
}

local c_cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

dap.configurations.c = c_cpp
dap.configurations.cpp = c_cpp
dap.configurations.rust = c_cpp

-- Python is configured by nvim-dap-python (see plugins/init.lua).
-- Java debugging is wired up automatically by nvim-jdtls (ftplugin/java.lua).
