return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim"
        -- Optional image support for file preview: See `# Preview Mode` for more information.
        -- {"3rd/image.nvim", opts = {}},
        -- OR use snacks.nvim's image module:
        -- "folke/snacks.nvim",
    },
    lazy = false, -- neo-tree will lazily load itself
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
        retain_hidden_root_indent = true,
        event_handlers = {
            {
                event = "neo_tree_buffer_enter",
                handler = function()
                    vim.opt_local.fillchars = {eob = " ", fold = "=", vert = "▏"}
                end
            }
        },
        filesystem = {
            components = {
                name = function(config, node, state)
                    local components = require("neo-tree.sources.common.components")
                    local name = components.name(config, node, state)

                    local home = vim.fn.expand("~")
                    local path = node.path
                    if path:sub(1, #home) == home and node:get_depth() == 1 then
                        name.text = " " .. path:sub(#home + 1)
                    end
                    return name
                end
            },
            filtered_items = {
                show_hidden_count = false,
                never_show = {
                    ".DS_Store"
                }
            }
        },
        default_component_configs = {
            indent = {
                with_expanders = true,
                expander_collapsed = "",
                expander_expanded = "",
                indent_marker = "│",
                last_indent_marker = "╰"
            },
            icon = {
                folder_closed = "󰉋",
                folder_open = "",
                folder_empty = "󰉖",
                folder_empty_open = ""
            }
        }
    }
}
