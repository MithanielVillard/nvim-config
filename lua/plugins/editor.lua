return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {"nvim-lua/plenary.nvim"},
		config = function ()
			require('telescope').load_extension('projects')
		end
    },
	{
    	"Mythos-404/xmake.nvim",
    	version = "^3",
    	lazy = true,
    	event = "BufReadPost",
    	config = true,
	},
	{
		'akinsho/toggleterm.nvim', version = "*", config = true
	},
	{
		'ahmedkhalf/project.nvim',
		config = function ()
			require("project_nvim").setup {
				patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".xmake", "CMakeLists.txt" }
    		}
		end
	},
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {"kevinhwang91/promise-async"},
        opts = {
            filetype_exclude = {
				"help",
				"alpha",
				"snacks_dashboard",
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
         				vim.opt_local.foldcolumn = '0'
                    end
                }
            )

            require("ufo").setup(opts)
        end
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = {enabled = true},
            bufdelete = {enabled = true},
            dashboard = {
                enabled = true,
                sections = {
                    {section = "header"},
                    {
                        pane = 2,
                        section = "terminal",
                        cmd = "bash " .. vim.fn.stdpath("config") .. "/misc/square",
                        height = 7,
                        padding = 1
                    },
                    {
                        pane = 2,
                        {
                            icon = " ",
                            title = "Recent Files",
                            padding = 1
                        },
                        {
                            section = "recent_files",
                            opts = {limit = 3},
                            indent = 2,
                            height = 10,
                            padding = 1
                        },
                        {
                            icon = " ",
                            title = "Projects",
                            padding = 1
                        },
                        {
                            section = "projects",
                            opts = {
								limit = 3,
								dirs = {"Test", ""}
							},
                            indent = 2,
                            padding = 1
                        }
                    },
                    {section = "keys", gap = 1, padding = 1},
                    {section = "startup", indent = 60}
                }
            },
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
