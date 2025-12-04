return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				-- Here you can add the languge servers you need
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"angularls",
					"cssls",
					"tailwindcss",
				},
				automatic_install = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Enable inlay hints globally
			vim.lsp.inlay_hint.enable(true)

			vim.lsp.enable("lua_ls")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("eslint")
			vim.lsp.enable("angularls")

			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show error in hover pop-up" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}