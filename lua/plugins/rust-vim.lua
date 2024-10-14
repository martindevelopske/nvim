return {
	"rust-lang/rust.vim",
	ft = "rust",
	init = function()
		vim.g.rustfmt_autosave = 1
	end,
}


-- Vim plugin that provides Rust file detection, syntax highlighting, formatting, Syntastic integration, and more
