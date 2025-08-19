return {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = {"rafamadriz/friendly-snippets"},
    -- use a release tag to download pre-built binaries
    version = "1.*",
	event = "LspAttach",
    opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = {
            preset = "enter",
            ["<C-k>"] = {"show_documentation", "hide_documentation"}
        },
        appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono"
        },
        enabled = function(ctx)

			local excludedTypes = {"string_content", "string", "comment", "line_comment", "comment_content", "block_comment"}

            local ts_utils = require("nvim-treesitter.ts_utils")
            local node = ts_utils.get_node_at_cursor(0, true)
            if node ~= nil and vim.list_contains(excludedTypes, node:type()) then
                return false
            else
                return true
            end
        end,

        -- (Default) Only show the documentation popup when manually triggered
        completion = {
            documentation = {auto_show = false, window = {border = "rounded"}},
            menu = {
                border = "rounded",
                draw = {
                    -- We don't need label_description now because label and label_description are already
                    -- combined together in label by colorful-menu.nvim.
                    columns = {{"kind_icon"}, {"label", gap = 1}},
                    components = {
                        label = {
                            text = function(ctx)
                                return require("colorful-menu").blink_components_text(ctx)
                            end,
                            highlight = function(ctx)
                                return require("colorful-menu").blink_components_highlight(ctx)
                            end
                        }
                    }
                }
            }
        },
        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = {"lsp", "path", "snippets", "buffer"}
        },
        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = {implementation = "prefer_rust_with_warning"}
    },
    opts_extend = {"sources.default"}
}

