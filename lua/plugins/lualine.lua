return {
    "nvim-lualine/lualine.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons", "AlexvZyl/nordic.nvim"},
    opts = function()
        return {
            extensions = {"neo-tree"},
            options = {
                component_separators = {left = "", right = ""},
                section_separators = {left = "", right = ""},
                theme = "nordic"
            },
            sections = {
                lualine_a = {
                    {"mode", separator = {left = "", right = ""}, right_padding = 2}
                }
            }
        }
    end
}
