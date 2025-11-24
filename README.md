# nvim-config

![Neovim](https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExNWg0MXpja3l0d2dsMjIwNGhycTF6cXNjcnZzMnF6OTIyMG84YjlwaCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ym6PmLonLGfv2/giphy.gif)

A minimal Neovim configuration using lazy.nvim as the plugin manager with Catppuccin colorscheme and Telescope fuzzy finder.

## Overview

This configuration provides a clean, minimal setup for Neovim with modern plugin management, a beautiful color scheme, and powerful fuzzy finding capabilities. It's designed to be simple yet extensible.

## Requirements

- Neovim >= 0.8.0 (for lazy.nvim compatibility)
- Git (for plugin installation)
- A terminal with true color support (for Catppuccin theme)
- Ripgrep (for Telescope text searching)
  - Telescope runs ripgrep as an external command-line process to search for text, making it a system-level dependency rather than a Neovim plugin itself.
  - Install it via your package manager, e.g., `brew install ripgrep` on macOS or `sudo apt install ripgrep` on Ubuntu.

## Features

- **Modern Plugin Management**: Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for fast and efficient plugin loading
- **Beautiful Theme**: Catppuccin Frappe colorscheme for a pleasant coding experience
- **Fuzzy Finding**: Telescope for fast file and text searching
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

Currently configured plugins:

- **Catppuccin**: A soothing pastel theme for Neovim
  - Priority: 1000 (loaded early)
  - Flavour: Frappe
  - Automatically applied as the colorscheme
- **Telescope**: Highly extendable fuzzy finder
  - Version: v0.1.9 (stable tag)
  - Dependencies: plenary.nvim
  - Configured to ignore `node_modules` in live grep searches

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

### Custom Keymaps

| Key          | Mode   | Action               | Description              |
| ------------ | ------ | -------------------- | ------------------------ |
| `<C-p>`      | Normal | `builtin.find_files` | Find files in project    |
| `<leader>fg` | Normal | `builtin.live_grep`  | Search text across files |

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

To add new plugins, edit the `spec` table in the `require("lazy").setup()` call:

```lua
require("lazy").setup({
  spec = {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { "nvim-telescope/telescope.nvim", tag = "v0.1.9", dependencies = { "nvim-lua/plenary.nvim" } },
    -- Add new plugins here, for example:
    -- { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  },
  -- ... rest of config
})
```

## Requirements

- Neovim >= 0.8.0 (for lazy.nvim compatibility)
- Git (for plugin installation)
- A terminal with true color support (for Catppuccin theme)

## File Structure

```
.
├── init.lua          # Main configuration file
├── LICENSE           # License information
└── README.md         # This file
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

### Changing Catppuccin Flavour

To change the theme variant, edit the `flavour` in the Catppuccin setup:

```lua
require("catppuccin").setup({
  flavour = "frappe", -- Options: latte, frappe, macchiato, mocha
})
```

## References

- [Neovim Documentation](https://neovim.io/doc/)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [Catppuccin](https://github.com/catppuccin/nvim)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Ripgrep](https://github.com/BurntSushi/ripgrep)
