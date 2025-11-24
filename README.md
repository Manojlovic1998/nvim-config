# nvim-config

![Neovim](https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExNWg0MXpja3l0d2dsMjIwNGhycTF6cXNjcnZzMnF6OTIyMG84YjlwaCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ym6PmLonLGfv2/giphy.gif)

A minimal Neovim configuration using lazy.nvim as the plugin manager with Catppuccin colorscheme.

## Overview

This configuration provides a clean, minimal setup for Neovim with modern plugin management and a beautiful color scheme. It's designed to be simple yet extensible.

## Features

- **Modern Plugin Management**: Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for fast and efficient plugin loading
- **Beautiful Theme**: Catppuccin colorscheme for a pleasant coding experience
- **Sensible Defaults**: Pre-configured indentation settings using spaces
- **Automatic Updates**: Plugin checker enabled to keep dependencies up-to-date

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
  - Automatically applied as the colorscheme

### Lazy.nvim Settings

- **Install colorscheme**: Uses "habamax" as fallback during plugin installation
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
    -- Add new plugins here, for example:
    -- { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
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

## References

- [Neovim Documentation](https://neovim.io/doc/)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [Catppuccin](https://github.com/catppuccin/nvim)
