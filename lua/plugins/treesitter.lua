return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	ensure_installed = { "javascript", "markdown", "vim", "vimdoc", "lua" },
	sync_install = false,
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },
}
