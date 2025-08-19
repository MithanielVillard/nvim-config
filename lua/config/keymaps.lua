-- Keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<leader>h', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader>l', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<leader>j', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<leader>k', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>", { desc = 'Toggle file explorer' })

vim.keymap.set("n", '<C-l>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Go to next tab'})
vim.keymap.set("n", '<C-h>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Go to previous tab'})

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = 'Yank to clipboard'})
vim.keymap.set("n", "<leader>v", [["+p]], { desc = 'Paste from clipboard' })

vim.keymap.set("v", "<M>j", ":m '>+1<CR>gv=gv", { desc = 'Move line up'})
vim.keymap.set("v", "<M>k", ":m '<-2<CR>gv=gv", { desc = 'Move line down'})

-- paste over without losing buffer
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = 'Paste over'})

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fc', '<cmd>Telescope treesitter<CR>', { desc = 'Telescope code find' })

vim.keymap.set('n', '<leader>gd', '<Cmd>Telescope lsp_definitions', { desc = 'Go to definition' })
vim.keymap.set('n', '<leader>gr', '<Cmd>Telescope lsp_references', { desc = 'Go to references' })

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Close terminal'})

vim.keymap.set('n', '<leader>x', function() Snacks.bufdelete() end, { desc = 'Close current buffer'})

vim.keymap.set({ "n", "x" }, "<leader>ca", function()
	require("tiny-code-action").code_action()
end, { noremap = true, silent = true, desc = 'Show code action' })

vim.keymap.set("n", "<M-CR>",
function()
	require("custom.actions").show_menu()
end, { desc = "Ouvrir le menu des actions" })

-- Debugging --
vim.keymap.set('n', "<leader>db", '<cmd>DapToggleBreakpoint<CR>', { desc = 'Toggle breakpoint'})
vim.keymap.set('n', "<leader>dc", '<cmd>DapContinue<CR>', { desc = 'Continue debbugging'})

-- Switching between cpp/h files --
local function toggle_header_source_same_tab()
  local ext = vim.fn.expand("%:e")
  local base = vim.fn.expand("%:r")
  local target

  if ext == "cpp" and vim.fn.filereadable(base .. ".h") == 1 then
    target = base .. ".h"
  elseif ext == "h" and vim.fn.filereadable(base .. ".cpp") == 1 then
    target = base .. ".cpp"
  else
    vim.notify("No pair file found", vim.log.levels.WARN)
    return
  end

  vim.cmd("keepalt file " .. target)
  vim.cmd("silent! edit")
end

vim.keymap.set("n", "<leader>ch", toggle_header_source_same_tab, { desc = 'Toggle between .cpp / .h'})
