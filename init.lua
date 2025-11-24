-- use spaces instead of tabs as characters
vim.opt.expandtab = true

-- use two spaces instead of a tab
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2


-- Bootstraping lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then

  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      {"Failed to clone lazy.nvim:\n", "ErrorMsg"},
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },

    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)



-- Make sure to setup `maploader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"



-- Setup lazy.nvim
require("lazy").setup({
  spec = {
  -- Add your plugins here
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- Automatically check for plugin updates
  checker = { enabled = true },
})

require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"