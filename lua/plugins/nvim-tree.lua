-- a file explorer for neovim
return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	config = function()
		vim.cmd([[hi NvimTreeNormal guibg=NONE ctermbg=NONE]])
		require("nvim-tree").setup({
			filters = {
				dotfiles = false,
				git_ignored = false,
       --  custom={"node_modules", ".git", ".github"}
			},
			view = {
				adaptive_size = true,
			},
		})
	end,
}
