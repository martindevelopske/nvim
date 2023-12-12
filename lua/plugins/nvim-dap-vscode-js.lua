local config = function()
	vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

	-- for name, sign in pairs(Config.icons.dap) do
	-- 	sign = type(sign) == "table" and sign or { sign }
	-- 	vim.fn.sign_define(
	-- 		"Dap" .. name,
	-- 		{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
	-- 	)
	-- end

	local debugger_path = "/home/rad/.local/share/nvim/lazy/vscode-js-debug/"

	require("dap-vscode-js").setup({
		debugger_path = debugger_path,
		adapters = {
			"chrome",
			"pwa-node",
			"pwa-chrome",
			"pwa-msedge",
			"pwa-extensionHost",
			"node-terminal",
		},
		log_file_path = "~/.cache/nvim-dap-vscode-js.log",
	})
end

return {
	"mxsdev/nvim-dap-vscode-js",
	event = "VeryLazy",
	config = config,
	dependencies = {
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui",
		{
			"microsoft/vscode-js-debug",
			build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
		},
		{
			-- enable parsing of vscode json launch configuration files
			"Joakker/lua-json5",
			build = "./install.sh",
		},
	},
}
