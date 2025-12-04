return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "v0.1.9",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function ()
      local telescope = require("telescope")

      telescope.setup({
        pickers = {
          live_grep = {
            file_ignore_patterns = { "node_modules" },
          }
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
          }
        }
      })


      telescope.load_extension("ui-select")


      local builtin = require("telescope.builtin");
      vim.keymap.set("n", "<C-p>", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope Live grep"})
    end
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
}