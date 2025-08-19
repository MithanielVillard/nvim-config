-- Autocommands
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = "SessionLoadPost",
  callback = function()
	  vim.cmd("Neotree reveal")
  end,
})
