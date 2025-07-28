-- Keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>", { desc = 'Toggle file explorer' })

vim.keymap.set("n", '<leader>l', '<cmd>BufferLineCycleNext<CR>', { desc = 'Go to next tab'})
vim.keymap.set("n", '<leader>h', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Go to previous tab'})

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = 'Yank to clipboard'})


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move line up'})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move line down'})

-- paste over without losing buffer
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = 'Paste over'})

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fc', '<cmd>Telescope treesitter<CR>', { desc = 'Telescope code find' })
vim.keymap.set('n', '<leader>gd', '<Cmd>lua require("telescope.builtin").lsp_definitions()<CR>', opts)

vim.keymap.set({ "n", "x" }, "<leader>ca", function()
	require("tiny-code-action").code_action()
end, { noremap = true, silent = true, desc = 'Show code action' })
