vim.api.nvim_create_user_command('Home', function(opts)
	vim.cmd("Neotree close")
	vim.cmd("wa")
	vim.cmd("SessionManager save_current_session")
	vim.cmd("cd /")
	vim.cmd("Dashboard")
 end, {})

 vim.api.nvim_create_user_command('CSharp', function (opts)
 	if (opts['args']) then
		local dir = vim.fn.getcwd() .. "/" .. opts['args']
		vim.cmd("tab terminal dotnet run --project=" .. dir)
	end
 end, { nargs = 1})
