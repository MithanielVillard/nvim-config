local Menu = require("nui.menu")
local event = require("nui.utils.autocmd").event

local M = {}

function M.show_menu()
local menu = Menu({
  relative = "cursor",
  position = { row = 3, col = 0},
  size = {
    width = 30,
    height = 7,
  },
  border = {
    style = "rounded",
    text = {
      top = "Code Actions",
      top_align = "center",
    },
  },
  win_options = {
    winhighlight = "Normal:Normal,FloatBorder:Normal",
  },
}, {
  lines = {
    Menu.item(" QuickFix", { cmd = function() require("tiny-code-action").code_action() end }),
    Menu.separator("Refactor", {
      char = "-",
      text_align = "left",
    }),
    Menu.item("󰏪 Rename", { cmd = function() vim.lsp.buf.rename() end}),
    Menu.item("󰍉 Go to definition", { cmd = function() require('telescope.builtin').lsp_definitions() end }),
    Menu.item("󱡴 Go to references", { cmd = function() require('telescope.builtin').lsp_references() end }),
    Menu.item("󰍉 Go to implementations", { cmd = function() require('telescope.builtin').lsp_implementations() end }),
    Menu.item(" Check spelling",{ cmd = function() require('telescope.builtin').spell_suggest() end } ),
  },
  max_width = 20,
  keymap = {
    focus_next = { "j", "<Down>", "<Tab>" },
    focus_prev = { "k", "<Up>", "<S-Tab>" },
    close = { "<Esc>", "<C-c>" },
    submit = { "<CR>", "<Space>" },
  },
  on_submit = function(item)
	item.cmd()
  end,
})

vim.api.nvim_set_hl(0, "Normale", { bg = "#1e1e2e", fg = "#cdd6f4" })

-- mount the component
menu:mount()
menu:on(event.BufLeave, menu.menu_props.on_close, { once = true })
end

return M
