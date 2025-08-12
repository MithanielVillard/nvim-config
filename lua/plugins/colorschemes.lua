return {
	{
   		'AlexvZyl/nordic.nvim',
   		 lazy = false,
   		 priority = 1000,
   		 config = function()
   		     require('nordic').load()
   		 end
	},
	{
		'rmehri01/onenord.nvim',
   		 lazy = false,
   		 priority = 1000,
   		 config = function()
   		     require('onenord').load()
   		 	vim.cmd([[colorscheme onenord]])
   		 end
	}
}
