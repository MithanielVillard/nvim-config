-- Vim Settings
vim.g.mapleader = " "

vim.o.number = true
vim.o.wrap = false

vim.o.tabstop = 4 
vim.o.shiftwidth = 4

vim.o.smartcase = true
vim.o.ignorecase = true

vim.o.signcolumn = 'yes'

vim.o.mouse = 'a'
vim.o.mousemoveevent = true

vim.o.undofile = true

vim.o.cursorline = true
vim.o.scrolloff = 10

vim.o.confirm = true

vim.o.foldcolumn = '1'
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- Disable number inside fold --
local fcs = vim.opt.fillchars:get()
local function get_fold(lnum)
	if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then return ' ' end
	return vim.fn.foldclosed(lnum) == -1 and fcs.foldopen or fcs.foldclose
end 
_G.get_statuscol = function()
	return "%s%l " .. get_fold(vim.v.lnum) .. " "
end
vim.o.statuscolumn = "%!v:lua.get_statuscol()" 
