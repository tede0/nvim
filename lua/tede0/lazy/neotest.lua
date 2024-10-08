return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-neotest/neotest-python",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					args = { "-v" }, -- get more diff
				}),
			},
			output = {
				-- disable pop-up with failing test info (prefer virtual text)
				open_on_run = false,
			},
			quickfix = {
				enabled = false,
			},
		})
	end,
	keys = {
		{ "<leader>st", "<CMD>Neotest summary toggle<CR>", desc = "Toggle Neotest" },
		{
			"<leader>op",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "Toggle Neotest Panel",
		},
		{ "<leader>tn", "<CMD>Neotest run<CR>", desc = "Test Nearest" },
		{ "<leader>ts", "<CMD>Neotest stop<CR>", desc = "Test Stop" },
		{ "<leader>tf", "<CMD>Neotest run file<CR>", desc = "Test File" },
		{
			"<leader>td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "Test Debug",
		},
	},
	cmd = "Neotest",
}
