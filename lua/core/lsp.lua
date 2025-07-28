vim.lsp.enable({
	"clangd",
	"lua_ls"
})

vim.lsp.config('clangd', {
  cmd = { 'clangd', "--compile-commands-dir=." },
})

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
