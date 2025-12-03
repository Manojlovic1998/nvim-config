# nvim-config

![Neovim](https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExNWg0MXpja3l0d2dsMjIwNGhycTF6cXNjcnZzMnF6OTIyMG84YjlwaCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ym6PmLonLGfv2/giphy.gif)

A modern Neovim configuration using lazy.nvim as the plugin manager with Catppuccin colorscheme, Telescope fuzzy finder, Treesitter syntax highlighting, LSP support via Mason, Neo-tree file explorer, None-ls for formatting/linting, and Snacks for enhanced UI features.

## Overview

This configuration provides a comprehensive setup for Neovim with modern plugin management, a beautiful color scheme, powerful fuzzy finding capabilities, advanced syntax highlighting, intelligent code completion, LSP integration for TypeScript, Lua, Angular, CSS, and Tailwind CSS development, automatic code formatting, and an enhanced dashboard experience. The modular structure makes it easy to customize and extend.

## Requirements

- Neovim >= 0.8.0 (for lazy.nvim compatibility)
- Git (for plugin installation)
- A terminal with true color support (for Catppuccin theme)
- Ripgrep (for Telescope text searching)
  - Telescope runs ripgrep as an external command-line process to search for text, making it a system-level dependency rather than a Neovim plugin itself.
  - Install it via your package manager, e.g., `brew install ripgrep` on macOS or `sudo apt install ripgrep` on Ubuntu.

## Features

- **Modern Plugin Management**: Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for fast and efficient plugin loading with modular configuration
- **Beautiful Theme**: Catppuccin Frappe colorscheme for a pleasant coding experience
- **Enhanced Dashboard**: Snacks.nvim dashboard with custom ASCII art on startup
- **Fuzzy Finding**: Telescope for fast file and text searching with UI enhancements
- **Syntax Highlighting**: Treesitter for accurate, context-aware syntax highlighting and code understanding
- **LSP Integration**: Mason-managed Language Server Protocol support for Lua, TypeScript, Angular, CSS, and Tailwind CSS
- **Formatting & Linting**: None-ls integration with Prettier, Stylua, and ESLint
- **File Explorer**: Neo-tree for visual file system navigation
- **Sensible Defaults**: Pre-configured indentation settings using spaces
- **Automatic Updates**: Plugin checker enabled to keep dependencies up-to-date
- **Custom Keybindings**: Configured shortcuts for common operations

## Configuration Breakdown

### Indentation Settings

```lua
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.tabstop = 2           -- Display tabs as 2 spaces
vim.opt.softtabstop = 2       -- Insert 2 spaces when Tab is pressed
vim.opt.shiftwidth = 2        -- Use 2 spaces for indentation
```

These settings configure Neovim to use 2 spaces for indentation across all operations.

### Lazy.nvim Bootstrap

The configuration automatically installs lazy.nvim if it's not present:

1. Checks if lazy.nvim exists in the data directory
2. If not found, clones it from the official repository
3. Uses `--filter=blob:none` for a faster, partial clone
4. Installs the stable branch
5. Handles errors gracefully with user feedback

### Leader Keys

```lua
vim.g.mapleader = " "         -- Space as the main leader key
vim.g.maplocalleader = "\\"   -- Backslash as the local leader key
```

Leader keys are set before loading plugins to ensure custom mappings work correctly.

### Plugin Configuration

All plugins are organized in separate files under `lua/plugins/` for better maintainability:

- **Catppuccin** (`lua/plugins/catppuccin.lua`): A soothing pastel theme
  - Priority: 1000 (loaded early)
  - Flavour: Frappe
  - Automatically applied as the colorscheme
- **Telescope** (`lua/plugins/telescope.lua`): Highly extendable fuzzy finder

  - Version: v0.1.9 (stable tag)
  - Dependencies: plenary.nvim
  - Extensions: telescope-ui-select for enhanced UI selections
  - Configured to ignore `node_modules` in live grep searches

- **Treesitter** (`lua/plugins/treesitter.lua`): Advanced syntax highlighting

  - Branch: master
  - Lazy loading: disabled (loads immediately)
  - Auto-update parsers on install
  - Pre-configured languages: JavaScript, Markdown, Vim, Vimdoc, Lua
  - Auto-install parsers for opened file types
  - Syntax highlighting and smart indentation enabled

- **Mason & LSP** (`lua/plugins/mason-lsp-manager.lua`): Language server management

  - Mason: LSP server installer and manager
  - Mason-lspconfig: Bridge between Mason and nvim-lspconfig
  - nvim-lspconfig: LSP client configurations
  - Pre-installed servers: lua_ls (Lua), ts_ls (TypeScript), angularls (Angular), cssls (CSS), tailwindcss (Tailwind CSS)
  - Enabled servers: lua_ls, ts_ls, eslint, angularls
  - Automatic installation enabled

- **None-ls** (`lua/plugins/none-ls.lua`): Formatting and linting integration

  - Formatters: Prettier (JavaScript/TypeScript/JSON/etc), Stylua (Lua)
  - Linters: ESLint (with none-ls-extras)
  - Additional: Spell completion
  - Keybinding: `<leader>gf` to format current buffer

- **Snacks** (`lua/plugins/snacks.nvim`): Enhanced UI features

  - Priority: 1000 (loaded early)
  - Dashboard enabled with custom ASCII art
  - Lazy loading: false (always available)

- **Neo-tree** (`lua/plugins/neo-tree.lua`): File system explorer
  - Branch: v3.x
  - Dependencies: plenary.nvim, nui.nvim, nvim-web-devicons
  - Lazy loading: false (always available)
  - Keybinding: `Ctrl+N` to toggle file tree

### Telescope Configuration

```lua
telescope.setup({
  pickers = {
    live_grep = {
      file_ignore_patterns = { "node_modules" },
    }
  }
})
```

This configuration excludes `node_modules` directories from text searches to improve performance.

### Treesitter Configuration

```lua
{
  "nvim-treesitter/nvim-treesitter",
  branch = 'master',
  lazy = false,
  build = ":TSUpdate",
  ensure_installed = { "javascript", "markdown", "vim", "vimdoc", "lua" },
  sync_install = false,
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
}
```

**Key features:**

- **ensure_installed**: Guarantees these parsers are always installed
- **auto_install**: Automatically installs parsers for new file types
- **highlight**: Enables Treesitter-based syntax highlighting
- **indent**: Enables smart, context-aware indentation
- **build**: Runs `:TSUpdate` to update all parsers on plugin install/update

### Mason & LSP Configuration

```lua
-- Mason setup
require("mason").setup()

-- Mason-lspconfig setup
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",        -- Lua
    "ts_ls",         -- TypeScript/JavaScript
    "angularls",     -- Angular
    "cssls",         -- CSS
    "tailwindcss",   -- Tailwind CSS
  },
})

-- Enable LSP servers
vim.lsp.enable("lua_ls")      -- Lua language server
vim.lsp.enable("ts_ls")       -- TypeScript server
vim.lsp.enable("eslint")      -- ESLint server
vim.lsp.enable("angularls")   -- Angular language server
```

**Key features:**

- **Mason**: Provides a UI (`:Mason`) to install/manage LSP servers, DAP servers, linters, and formatters
- **Automatic installation**: Specified servers are automatically installed on first launch
- **Language support**: Pre-configured for Lua, TypeScript/JavaScript, Angular, CSS, and Tailwind CSS development
- **Extensible**: Easy to add more language servers via `ensure_installed`

### None-ls Configuration

```lua
local null_ls = require("null-ls")

null_ls.setup({
  null_ls.builtins.completion.spell,              -- Spell completion
  null_ls.builtins.formatting.stylua,             -- Lua formatter
  null_ls.builtins.formatting.prettier,           -- JS/TS/JSON/etc formatter
  require("none-ls.diagnostics.eslint"),          -- ESLint diagnostics
})

vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
```

**Key features:**

- **Formatters**: Automatically format code with Prettier and Stylua
- **Linting**: ESLint integration for JavaScript/TypeScript projects
- **Spell check**: Built-in spell completion support
- **Dependencies**: Requires none-ls-extras.nvim for ESLint integration

### Snacks Configuration

```lua
opts = {
  dashboard = {
    enabled = true,
    preset = {
      header = [[ Custom ASCII Art ]]
    },
  },
}
```

**Key features:**

- **Dashboard**: Custom welcome screen with ASCII art displayed on Neovim startup
- **High priority**: Loads early to ensure dashboard appears first
- **Always available**: Not lazy-loaded for immediate startup experience

### Custom Keymaps

#### Telescope

| Key          | Mode   | Action               | Description              |
| ------------ | ------ | -------------------- | ------------------------ |
| `<C-p>`      | Normal | `builtin.find_files` | Find files in project    |
| `<leader>fg` | Normal | `builtin.live_grep`  | Search text across files |

#### LSP

| Key          | Mode          | Action                    | Description                 |
| ------------ | ------------- | ------------------------- | --------------------------- |
| `K`          | Normal        | `vim.lsp.buf.hover`       | Show documentation in hover |
| `gd`         | Normal        | `vim.lsp.buf.definition`  | Go to definition            |
| `<leader>ca` | Normal/Visual | `vim.lsp.buf.code_action` | Show code actions           |

#### Formatting (None-ls)

| Key          | Mode   | Action               | Description           |
| ------------ | ------ | -------------------- | --------------------- |
| `<leader>gf` | Normal | `vim.lsp.buf.format` | Format current buffer |

#### Neo-tree

| Key     | Mode   | Action                            | Description      |
| ------- | ------ | --------------------------------- | ---------------- |
| `<C-n>` | Normal | `:Neotree filesystem reveal left` | Toggle file tree |

### Lazy.nvim Settings

- **Install colorscheme**: Uses "catppuccin" during plugin installation
- **Auto-checker**: Enabled to automatically check for plugin updates

## Installation

1. Clone this repository to your Neovim config directory:

   ```bash
   git clone <repository-url> ~/.config/nvim
   ```

2. Launch Neovim:

   ```bash
   nvim
   ```

3. Lazy.nvim will automatically bootstrap and install all plugins on first launch.

## Adding More Plugins

The configuration uses a modular approach. Create a new file in `lua/plugins/` for each plugin:

**Example: Adding nvim-cmp for autocompletion**

Create `lua/plugins/nvim-cmp.lua`:

```lua
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      -- Your configuration here
    })
  end
}
```

Lazy.nvim automatically loads all files from `lua/plugins/` directory. No need to modify `init.lua`!

## Requirements

- Neovim >= 0.8.0 (for lazy.nvim compatibility)
- Git (for plugin installation)
- A terminal with true color support (for Catppuccin theme)

## File Structure

```
.
├── init.lua                              # Entry point - loads lazy.nvim
├── lua/
│   ├── config/
│   │   └── lazy.lua                      # Lazy.nvim bootstrap & settings
│   └── plugins/
│       ├── catppuccin.lua                # Theme configuration
│       ├── telescope.lua                 # Fuzzy finder setup
│       ├── treesitter.lua                # Syntax highlighting
│       ├── mason-lsp-manager.lua         # LSP management
│       ├── none-ls.lua                   # Formatting & linting
│       ├── snacks.lua                    # Dashboard & UI enhancements
│       └── neo-tree.lua                  # File explorer
├── tmux-config/                          # Tmux configuration files
├── alacritty-config/                     # Alacritty terminal config
├── LICENSE
└── README.md
```

## Customization

This configuration is intentionally minimal to serve as a starting point. You can extend it by:

- Adding more plugins to the lazy.nvim spec
- Creating custom keymaps using the leader keys
- Adding language-specific configurations
- Setting up LSP, treesitter, and other development tools

## Tmux Integration

If you use tmux, proper terminal color configuration is **critical** for the Catppuccin theme to display correctly.

### True Color Support Configuration

Add these settings to your `.tmux.conf` (located in `tmux-config/.tmux`):

```bash
# Enable true color support (24-bit RGB colors)
set -g default-terminal "tmux-256color"
set -ag terminal-overrides ",xterm-256color:RGB"
```

**Why these settings matter:**

- **`default-terminal "tmux-256color"`**: Tells tmux to advertise itself as a 256-color capable terminal, establishing the foundation for extended color support.

- **`terminal-overrides ",xterm-256color:RGB"`**: Enables TRUE COLOR support (16 million colors) beyond the basic 256 colors. This is essential for modern colorschemes like Catppuccin.

**Without these settings:**

- The Catppuccin theme will appear washed out or display incorrect colors
- Neovim won't be able to render full RGB colors inside tmux sessions
- Modern terminal emulators (Alacritty, Kitty, iTerm2) won't work properly with Neovim

### Verifying True Color Support

To verify that true colors are working in your tmux + Neovim setup:

```bash
# Inside tmux, run:
echo $TERM
# Should output: tmux-256color
```

Then in Neovim, run `:checkhealth` and look for terminal capabilities confirming RGB/true-color support.

## Usage

### Telescope Commands

- **Find Files**: Press `Ctrl+P` to open the file finder
- **Live Grep**: Press `Space` (leader) + `fg` to search for text across all files
- Navigate results with arrow keys or `Ctrl+j`/`Ctrl+k`
- Press `Enter` to open a file

### LSP Commands

- **Hover Documentation**: Press `K` in normal mode to see documentation for symbol under cursor
- **Go to Definition**: Press `gd` to jump to the definition of a symbol
- **Code Actions**: Press `Space` + `ca` to see available code actions (fixes, refactoring, etc.)
- **LSP Management**: Run `:Mason` to open the Mason UI for installing/managing language servers

### Formatting & Linting

- **Format Code**: Press `Space` + `gf` to format the current buffer using configured formatters (Prettier, Stylua)
- **Auto-format**: Formatters automatically detect file type and apply appropriate formatting
- **ESLint**: Diagnostics appear automatically for JavaScript/TypeScript files
- **External Dependencies**:
  - Install Prettier globally: `npm install -g prettier`
  - Install Stylua: `cargo install stylua` or via package manager

### Neo-tree File Explorer

- **Toggle File Tree**: Press `Ctrl+N` to open/close the file explorer
- Navigate with arrow keys or `j`/`k`
- Press `Enter` to open a file
- Press `?` inside Neo-tree to see all available commands

### Managing Language Servers

To add a new language server:

1. Open the Mason UI with `:Mason`
2. Search for your language server
3. Press `i` to install
4. Add it to `ensure_installed` in `lua/plugins/mason-lsp-manager.lua`
5. Enable it with `vim.lsp.enable("server_name")`

### Changing Catppuccin Flavour

To change the theme variant, edit `lua/plugins/catppuccin.lua`:

```lua
config = function()
  require("catppuccin").setup({
    flavour = "frappe", -- Options: latte, frappe, macchiato, mocha
  })
  vim.cmd.colorscheme "catppuccin-frappe"
end
```

## References

- [Neovim Documentation](https://neovim.io/doc/)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [Catppuccin](https://github.com/catppuccin/nvim)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [Mason](https://github.com/williamboman/mason.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [None-ls](https://github.com/nvimtools/none-ls.nvim)
- [Snacks.nvim](https://github.com/folke/snacks.nvim)
- [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim)
- [Ripgrep](https://github.com/BurntSushi/ripgrep)
- [Prettier](https://prettier.io/)
- [Stylua](https://github.com/JohnnyMorganz/StyLua)
