return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
        	defaults = {
  				{ "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
        	},
        },
    }
}

