return {
  -- FORMATTING ------------------------------------------------------------
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  -- LSP -------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Mason: auto-install every LSP / formatter / linter / debug adapter ----
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "VeryLazy",
    opts = {
      run_on_start = true,
      ensure_installed = {
        -- Language servers
        "pyright",
        "ruff",
        "clangd",
        "jdtls",
        "lua-language-server",
        "typescript-language-server",
        "html-lsp",
        "css-lsp",
        "json-lsp",
        "yaml-language-server",
        "bash-language-server",
        "rust-analyzer",
        "gopls",
        "marksman",
        "dockerfile-language-server",
        "taplo",
        "cmake-language-server",
        -- Formatters
        "stylua",
        "black",
        "isort",
        "clang-format",
        "google-java-format",
        "prettier",
        "prettierd",
        "shfmt",
        "goimports",
        -- Linters
        "shellcheck",
        "eslint_d",
        "cpplint",
        -- Debug adapters
        "debugpy",
        "codelldb",
        "java-debug-adapter",
        "java-test",
      },
    },
  },

  -- TREESITTER: syntax highlighting + code-aware text objects -------------
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    opts = {
      ensure_installed = {
        "lua", "luadoc", "vim", "vimdoc",
        "python", "java", "c", "cpp", "cmake", "make",
        "javascript", "typescript", "tsx",
        "html", "css", "json", "jsonc",
        "yaml", "toml", "bash", "rust", "go", "gomod",
        "markdown", "markdown_inline", "dockerfile", "gitignore", "regex",
      },
      highlight = { enable = true, use_languagetree = true },
      indent = { enable = true },
      -- Select / move by function, class, parameter
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
        },
      },
    },
  },

  -- LINTING ---------------------------------------------------------------
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.lint"
    end,
  },

  -- JAVA (jdtls) ----------------------------------------------------------
  -- No config here; ftplugin/java.lua starts it per-buffer.
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },

  -- DEBUGGING -------------------------------------------------------------
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "DAP continue/start" },
      { "<leader>di", function() require("dap").step_into() end, desc = "DAP step into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "DAP step over" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "DAP step out" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "DAP REPL" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "DAP terminate" },
    },
    config = function()
      require "configs.dap"
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      -- debugpy is installed by Mason under this path
      require("dap-python").setup(vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python")
    end,
  },

  -- DIAGNOSTICS / SYMBOLS PANEL ------------------------------------------
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
  },

  -- TODO / FIXME highlighting + search -----------------------------------
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- CODE FOLDING (nvim-ufo) ----------------------------------------------
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      local ufo = require "ufo"
      vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })

      ufo.setup {
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
      }
    end,
  },

  -- BREADCRUMBS in the winbar (needs navic attached in lspconfig.lua) -----
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    event = "LspAttach",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      attach_navic = false, -- we attach navic ourselves in configs/lspconfig.lua
      show_dirname = false,
      theme = "auto",
    },
  },

  -- RAINBOW BRACKETS (aesthetic) -----------------------------------------
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("rainbow-delimiters.setup").setup {}
    end,
  },

  -- GIT signs come with NvChad; add a git diff view + blame line ----------
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  },
}
