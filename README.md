# Neovim Configuration

A personal Neovim configuration built on top of [NvChad v2.5](https://github.com/NvChad/NvChad), with LSP support for Java, Python, C/C++, and HTML/CSS, format-on-save, and a transparent background.

## Features

- NvChad v2.5 base framework with the `vscode_dark` theme
- LSP via `nvim-lspconfig` for Java (`jdtls`), Python (`pyright`), C/C++ (`clangd`), HTML, and CSS
- Format-on-save via `conform.nvim` (Stylua for Lua, Black for Python, Checkstyle for Java)
- Treesitter syntax highlighting for Java, Lua, Python, and Bash
- Fuzzy finding with `telescope.nvim`
- File tree with `nvim-tree`
- Autocompletion via `nvim-cmp` with LSP, buffer, path, and snippet sources
- Git integration with `gitsigns.nvim`
- Transparent background
- 4-space indentation with smart auto-indent

## Requirements

- [Neovim](https://github.com/neovim/neovim) >= 0.10
- [Git](https://git-scm.com/)
- A [Nerd Font](https://www.nerdfonts.com/) for icons
- `node` and `npm` for some LSP servers
- Language-specific tools (see [LSP and Formatters](#lsp-and-formatters))

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

On first launch, `lazy.nvim` bootstraps itself and installs all plugins automatically. Wait for it to finish, then restart Neovim.

## LSP and Formatters

Install language servers and formatters via [Mason](https://github.com/williamboman/mason.nvim) (run `:Mason` inside Neovim) or manually.

| Language | LSP Server | Formatter    |
|----------|------------|--------------|
| Java     | `jdtls`    | `checkstyle` |
| Python   | `pyright`  | `black`      |
| Lua      | `lua_ls`   | `stylua`     |
| C/C++    | `clangd`   | —            |
| HTML     | `html`     | —            |
| CSS      | `cssls`    | —            |

## Structure

```
~/.config/nvim/
├── init.lua               # Entry point: bootstraps lazy.nvim and loads plugins
├── lazy-lock.json         # Plugin version lockfile
└── lua/
    ├── chadrc.lua         # NvChad theme and UI config (vscode_dark)
    ├── mappings.lua       # Custom keymaps
    ├── options.lua        # Editor options (tabs, indentation, transparency)
    ├── configs/
    │   ├── lazy.lua       # lazy.nvim performance settings
    │   ├── lspconfig.lua  # LSP server setup
    │   └── conform.lua    # Formatter configuration
    └── plugins/
        └── init.lua       # Plugin declarations
```

## Key Mappings

Custom mappings on top of NvChad defaults:

| Mode   | Key  | Action                |
|--------|------|-----------------------|
| Normal | `;`  | Enter command mode    |
| Insert | `jk` | Escape to normal mode |

All NvChad default mappings apply. Run `:WhichKey` or press `<Space>` to explore them.

## Theme

Uses `vscode_dark` from NvChad's base46 theme engine. To change it, edit `lua/chadrc.lua`:

```lua
M.base46 = {
  theme = "vscode_dark", -- change this to any base46 theme
}
```

Run `:Telescope themes` to preview available themes.

## Plugin Manager

Uses [lazy.nvim](https://github.com/folke/lazy.nvim) with lazy-loading enabled by default for fast startup. Run `:Lazy` to manage plugins.

