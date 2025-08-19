vim.api.nvim_create_user_command('Home', function(opts)
	vim.cmd("Neotree close")
	vim.cmd("wa")
	vim.cmd("SessionManager save_current_session")
	vim.cmd("cd /")
	vim.cmd("Dashboard")
 end, {})

