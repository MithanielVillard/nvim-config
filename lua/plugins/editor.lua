return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {"nvim-lua/plenary.nvim"},
        config = function()
            require("telescope").setup(
                {
                    defaults = {
                        file_ignore_patterns = {
                            ".git",
                            ".cache",
                            "%.o",
                            "%.a",
                            "%.out",
                            "%.class",
                            "%.pdf",
                            "%.mkv",
                            "%.mp4",
                            "%.zip"
                        }
                    }
                })
			require("telescope").load_extension("workspaces")
		end
	},
    {
        "Mythos-404/xmake.nvim",
        version = "^3",
        lazy = true,
        event = "BufReadPost",
        config = true
    },
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = true
    },
    {
        "Shatur/neovim-session-manager",
        dependencies = {"nvim-lua/plenary.nvim"},
        opts = function()
            local config = require("session_manager.config")
            return {
                autoload_mode = config.AutoloadMode.Disabled
            }
        end
    },
	{
		"natecraddock/workspaces.nvim",
		opts = {
			hooks = {
				open_pre = {
					"silent %bdelete!",
				},
        		open = {"SessionManager load_current_dir_session"}
			}
		}
	},
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {"kevinhwang91/promise-async"},
        opts = {
            filetype_exclude = {
                "help",
                "alpha",
                "dashboard",
                "neo-tree",
                "lazy",
                "mason",
                "dapui_watches",
                "dapui_breakpoints",
                "dapui_scopes",
                "dapui_console",
                "dapui_stacks",
                "dap-repl"
            }
        },
        config = function(_, opts)
            vim.api.nvim_create_autocmd(
                "FileType",
                {
                    pattern = opts.filetype_exclude,
                    callback = function()
                        require("ufo").detach()
                        vim.opt_local.foldenable = false
                        vim.opt_local.foldcolumn = "0"
                    end
                }
            )

            require("ufo").setup(opts)
        end
    },
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        config = function()
            require("dashboard").setup {
                theme = "hyper",
                config = {
                    week_header = {
                        enable = true
                    },
                    shortcut = {
                        {desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u"},
                        {
                            icon = " ",
                            icon_hl = "@variable",
                            desc = "Files",
                            group = "Label",
                            action = "Telescope find_files",
                            key = "f"
                        },
                        {
                            desc = "󰣖 Config",
                            group = "DiagnosticHint",
                            action = "lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                            key = "c"
                        },
                        {
                            desc = " Project",
                            group = "Number",
                            action = "Telescope workspaces",
                            key = "p"
                        },
                        {
                            desc = "󰁫 Restore session",
                            group = "Session",
                            action = "SessionManager load_last_session",
                            key = "r"
                        }
                    },
                }
            }
        end,
        dependencies = {{"nvim-tree/nvim-web-devicons"}}
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = {enabled = true},
            bufdelete = {enabled = true},
            indent = {enabled = true},
            quickfile = {enabled = true},
            scope = {enabled = true}
        }
    },
    {
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
                    name_formatter = function(buf)
                        local file = vim.split(buf.name, ".", {plain = true})
                        local paired_ext = (file[2] == "cpp" and "h") or (file[2] == "h" and "cpp") or nil
                        if paired_ext then
                            local paired_file = vim.fn.fnamemodify(buf.path, ":r") .. "." .. paired_ext
                            if vim.fn.filereadable(paired_file) == 1 then
                                if file[2] == "cpp" then
                                    return file[1] .. " 󰯲 ↔ 󰰂"
                                else
                                    return file[1] .. " 󰯳 ↔ 󰰁"
                                end
                            end
                        end
                        return vim.fn.fnamemodify(buf.name, ":t")
                    end,
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
    },
    {
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            config = true
            -- use opts = {} for passing setup options
            -- this is equivalent to setup({}) function
        }
    },
    {
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
}
