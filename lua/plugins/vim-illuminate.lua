return {
	"RRethy/vim-illuminate",
	lazy = false,
	config = function()
		require("illuminate").configure({})
	end,
}

-- for automatically highlighting other uses of the word under the cursor using either LSP, Tree sitter or regex matching
