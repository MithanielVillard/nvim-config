return {
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons" -- optional dependency
        },
        opts = {
            show_dirname = true
        }
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true -- requires hrsh7th/nvim-cmp
                }
            },
            presets = {
                lsp_doc_border = false -- add a border to hover docs and signature help
            }
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify"
        }
    },
    {
        "sphamba/smear-cursor.nvim",
        opts = {
            stiffness = 0.8,
            trailing_stiffness = 0.5,
            stiffness_insert_mode = 0.7,
            trailing_stiffness_insert_mode = 0.7,
            damping = 0.8,
            damping_insert_mode = 0.8,
            distance_stop_animating = 0.5,
            trailing_exponent = 5
        }
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {"nvim-tree/nvim-web-devicons", "AlexvZyl/nordic.nvim"},
        opts = function()
            return {
                extensions = {"neo-tree", "toggleterm", "mason", "lazy", "nvim-dap-ui"},
                options = {
                    component_separators = {left = "", right = ""},
                    section_separators = {left = "", right = ""},
                    theme = "onenord",
                },
                sections = {
                    lualine_a = {
                        {"mode", separator = {left = "", right = ""}, right_padding = 2}
                    },
                    lualine_b = {
                        {"lsp_status"}
                    },
					lualine_y  = {
						{
                			function()
                			    if not vim.g.loaded_xmake then return "" end
                			    local Info = require("xmake.info")
                			    if Info.mode.current == "" then return "" end
                			    if Info.target.current == "" then return "Xmake No " end
                			    return ("%s (%s)"):format(Info.target.current, Info.mode.current)
                			end,
                			cond = function()
                			    return vim.o.columns > 100
                			end,
						}
					}
                }
            }
        end
    }
}
