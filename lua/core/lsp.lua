vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {
          'vim',
          'require',
        },
      },
	  workspace = {
         library = vim.api.nvim_get_runtime_file("", true),
    	},
    },
  },
})

vim.lsp.config['clangd'] = {
  cmd = { 'clangd', '--compile-commands-dir=.' },
}

vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = true,
	underline = true,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true
	},
	 signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})
