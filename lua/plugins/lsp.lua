return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {"neovim/nvim-lspconfig", "williamboman/mason.nvim"},
        config = function()
			local lspconfig = require("lspconfig")
            require("mason-lspconfig").setup(
                {
                    ensure_installed = {"clangd", "lua_ls"}, -- tu peux ajouter plus de serveurs ici
                    automatic_installation = true,
                    handlers = {
                        function(server_name)
                            require("lspconfig")[server_name].setup {}
                        end,
                    }
                }
            )
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        lazy = false,
        build = ":TSUpdate",
        main = "nvim-treesitter.configs", -- Sets main module to use for opts
        opt = {
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "diff",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "query",
                "vim",
                "vimdoc"
            },
            -- Autoinstall languages that are not installed
            auto_install = true,
            highlight = {
                enable = true,
                -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
                --  If you are experiencing weird indenting issues, add the language to
                --  the list of additional_vim_regex_highlighting and disabled languages for indent.
                additional_vim_regex_highlighting = {"ruby"}
            },
            indent = {enable = true, disable = {"ruby"}}
        }
    }
}

