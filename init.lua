-- use spaces instead of tabs as characters
vim.opt.expandtab = true

-- use two spaces instead of a tab
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.g.mapleader = " "

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
    { 
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000 
    },
    { 
      "nvim-telescope/telescope.nvim",
      tag = "v0.1.9", 
      dependencies = { "nvim-lua/plenary.nvim" },
    }
	},
  install = { colorscheme = { "catppuccin" } },
	-- Automatically check for plugin updates
	checker = { enabled = true },
})

local telescope = require("telescope")

telescope.setup({
  pickers = {
    live_grep = {
      file_ignore_patterns = { "node_modules" },
    }
  }

})


local builtin = require("telescope.builtin");

vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope Live grep"})

require("catppuccin").setup({
  flavour = "frappe", -- late, frappe, macchiato, mocha
})

vim.cmd.colorscheme "catppuccin-frappe"

