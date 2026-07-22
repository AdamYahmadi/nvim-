# Neovim Configuration

A personal Neovim configuration built on top of [NvChad v2.5](https://github.com/NvChad/NvChad), set up as a full development environment for Java, Python, and C/C++, with debugging, linting, format-on-save, and code navigation.

## Features

- NvChad v2.5 base framework with the `catppuccin` theme
- **LSP** via `nvim-lspconfig` using the Neovim 0.11 `vim.lsp.config` API — Python (`pyright` + `ruff`), C/C++ (`clangd`), Lua, TypeScript/JavaScript, HTML, CSS, JSON, YAML, Bash, Rust, Go, Markdown, Docker, TOML and CMake
- **Java** via `nvim-jdtls`, started per-buffer with an isolated project workspace, auto-import completion, and JUnit test running
- **Debugging** with `nvim-dap` + `nvim-dap-ui` — configured for Python (`debugpy`), C/C++/Rust (`codelldb`), and Java (`java-debug-adapter`)
- **Automatic tool installation** via `mason-tool-installer` — every LSP, formatter, linter and debug adapter installs on first launch
- **Format-on-save** via `conform.nvim` (Black + isort for Python, `google-java-format` for Java, `clang-format` for C/C++, Prettier for web)
- **Linting** via `nvim-lint` (shellcheck, eslint_d, cpplint)
- Treesitter syntax highlighting and code-aware text objects for all supported languages
- Diagnostics and symbol navigation with `trouble.nvim`
- Breadcrumbs in the winbar via `barbecue.nvim` + `nvim-navic`
- Code folding with `nvim-ufo`, rainbow brackets, and `todo-comments.nvim`
- Fuzzy finding with `telescope.nvim`, file tree with `nvim-tree`
- Autocompletion via `nvim-cmp` with LSP, buffer, path, and snippet sources
- Git integration with `gitsigns.nvim` and `diffview.nvim`
- 4-space indentation (2 for web and config filetypes) with smart auto-indent

## Requirements

- [Neovim](https://github.com/neovim/neovim) >= 0.11
- [Git](https://git-scm.com/), `ripgrep` and `fd`
- A [Nerd Font](https://www.nerdfonts.com/) for icons
- `node` and `npm` for some LSP servers and formatters
- A **JDK 17 or newer** on your `PATH` — required by `jdtls`
- Language-specific tools (see [LSP and Formatters](#lsp-and-formatters))

### macOS setup

```bash
brew install neovim ripgrep fd git node python openjdk@21
brew install --cask font-jetbrains-mono-nerd-font
```

Make sure `java -version` reports 17+:

```bash
echo 'export PATH="$(brew --prefix)/opt/openjdk@21/bin:$PATH"' >> ~/.zshrc
```

## Installation

Back up your existing config first if you have one.

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

# Clone this config
git clone https://github.com/AdamYahmadi/nvim-.git ~/.config/nvim

# Launch Neovim — lazy.nvim will auto-install all plugins
nvim
```

On first launch, `lazy.nvim` bootstraps itself and installs all plugins, then Mason installs every language server, formatter, linter and debug adapter automatically. Wait for it to finish, then restart Neovim.

The first time you open a Java file, `jdtls` builds its project index under `~/.cache/jdtls/workspace/`. This can take up to a minute — completion stays empty until it finishes.

## LSP and Formatters

All tools install automatically on first launch. Run `:Mason` to check status or install extras.

| Language  | LSP Server         | Formatter            | Linter       | Debugger             |
| --------- | ------------------ | -------------------- | ------------ | -------------------- |
| Java      | `jdtls`            | `google-java-format` | —            | `java-debug-adapter` |
| Python    | `pyright` + `ruff` | `black`, `isort`     | `ruff`       | `debugpy`            |
| C/C++     | `clangd`           | `clang-format`       | `cpplint`    | `codelldb`           |
| Lua       | `lua_ls`           | `stylua`             | —            | —                    |
| JS/TS     | `ts_ls`            | `prettierd`          | `eslint_d`   | —                    |
| Rust      | `rust_analyzer`    | `rustfmt`            | —            | `codelldb`           |
| Go        | `gopls`            | `goimports`, `gofmt` | —            | —                    |
| Bash      | `bashls`           | `shfmt`              | `shellcheck` | —                    |
| HTML/CSS  | `html`, `cssls`    | `prettierd`          | —            | —                    |
| JSON/YAML | `jsonls`, `yamlls` | `prettierd`          | —            | —                    |

## Structure

```
~/.config/nvim/
├── init.lua               # Entry point: bootstraps lazy.nvim and loads plugins
├── lazy-lock.json         # Plugin version lockfile (generated on first launch)
├── ftplugin/
│   └── java.lua           # jdtls setup, started per Java buffer
└── lua/
    ├── chadrc.lua         # NvChad theme and UI config
    ├── mappings.lua       # Custom keymaps
    ├── options.lua        # Editor options (tabs, indentation, search, UI)
    ├── configs/
    │   ├── lazy.lua       # lazy.nvim performance settings
    │   ├── lspconfig.lua  # LSP server setup
    │   ├── conform.lua    # Formatter configuration
    │   ├── lint.lua       # Linter configuration
    │   └── dap.lua        # Debugger configuration
    └── plugins/
        └── init.lua       # Plugin declarations
```

## Key Mappings

Custom mappings on top of NvChad defaults. Leader is `<Space>`.

| Mode          | Key          | Action                        |
| ------------- | ------------ | ----------------------------- |
| Normal        | `;`          | Enter command mode            |
| Insert        | `jk`         | Escape to normal mode         |
| Normal        | `K`          | Hover documentation           |
| Normal        | `gd` / `gr`  | Go to definition / references |
| Normal        | `gi`         | Go to implementation          |
| Normal/Visual | `<leader>ca` | Code action                   |
| Normal/Visual | `<leader>fm` | Format file or selection      |
| Normal        | `[d` / `]d`  | Previous / next diagnostic    |
| Normal        | `<leader>e`  | Show line diagnostics         |
| Normal        | `<leader>tt` | Trouble diagnostics list      |
| Normal        | `<leader>ts` | Trouble symbols outline       |
| Normal        | `<leader>db` | Toggle breakpoint             |
| Normal        | `<leader>dc` | Start / continue debugging    |
| Normal        | `<leader>du` | Toggle debugger UI            |
| Normal        | `<leader>di` | Step into                     |
| Normal        | `<leader>do` | Step over                     |
| Visual        | `J` / `K`    | Move selected lines down / up |
| Normal        | `zR` / `zM`  | Open / close all folds        |

### Java-specific (in `.java` buffers)

| Key          | Action                       |
| ------------ | ---------------------------- |
| `<leader>jo` | Organize imports             |
| `<leader>jv` | Extract variable             |
| `<leader>jc` | Extract constant             |
| `<leader>jm` | Extract method (visual mode) |
| `<leader>jt` | Run nearest test             |
| `<leader>jT` | Run test class               |

### Treesitter text objects

| Key         | Action                           |
| ----------- | -------------------------------- |
| `af` / `if` | Select around / inside function  |
| `ac` / `ic` | Select around / inside class     |
| `aa` / `ia` | Select around / inside parameter |
| `]f` / `[f` | Jump to next / previous function |

All NvChad default mappings apply. Run `:WhichKey` or press `<Space>` to explore them.

## Theme

Uses `catppuccin` from NvChad's base46 theme engine. To change it, edit `lua/chadrc.lua`:

```lua
M.base46 = {
  theme = "catppuccin", -- change this to any base46 theme
}
```

Run `:Telescope themes` or press `<leader>th` to preview available themes. Uncomment `transparency = true` in the same file for a transparent background.

## Plugin Manager

Uses [lazy.nvim](https://github.com/folke/lazy.nvim) with lazy-loading enabled by default for fast startup. Run `:Lazy` to manage plugins.

## Troubleshooting

Run `:checkhealth` first — it catches most issues.

- **No Java completion or missing imports** — make sure you opened a project root (a directory containing `.git`, `pom.xml`, `build.gradle`, `mvnw` or `gradlew`), not a standalone `.java` file. Verify `jdtls` attached with `:lua vim.print(vim.lsp.get_clients({ name = "jdtls" }))`.
- **Icons show as boxes** — set a Nerd Font as your terminal font.
- **A tool is missing** — run `:Mason` and install it manually.
