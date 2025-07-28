return {
    "akinsho/bufferline.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    opts = function()
        local bufferline = require("bufferline")
        return {
            options = {
                separator_style = "thick",
                close_command = function(buff)
                    Snacks.bufdelete(buff)
                end,
                middle_mouse_command = function(buff)
                    Snacks.bufdelete(buff)
                end,
                style_preset = bufferline.style_preset.no_italic,
                hover = {
                    enabled = true,
                    delay = 100,
                    reveal = {"close"}
                },
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        highlight = "Directory"
                    }
                }
            }
        }
    end
}

