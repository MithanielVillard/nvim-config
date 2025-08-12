return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()

			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
			vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#ff5555" })

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {"williamboman/mason.nvim", "mfussenegger/nvim-dap"},
        config = function()
            require("mason-nvim-dap").setup(
                {
                    ensure_installed = {"codelldb"},
                    automatic_installation = true,
                    handlers = {
                        function(config)
                            require("mason-nvim-dap").default_setup(config)
                        end,
                        codelldb = function(config)
                            local mason_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
                            local codelldb_path = mason_path .. "adapter/codelldb"
                            local liblldb_path = mason_path .. "lldb/lib/liblldb.so" -- Linux

                            if vim.loop.os_uname().sysname == "Darwin" then
                                liblldb_path = mason_path .. "lldb/lib/liblldb.dylib"
                            elseif vim.loop.os_uname().sysname:find("Windows") then
                                codelldb_path = mason_path .. "adapter\\codelldb.exe"
                                liblldb_path = mason_path .. "lldb\\bin\\liblldb.dll"
                            end

                            config.adapter =
                                require("dap").adapters.codelldb or
                                {
                                    type = "server",
                                    port = "${port}",
                                    executable = {
                                        command = codelldb_path,
                                        args = {"--liblldb", liblldb_path, "--port", "${port}"}
                                    }
                                }

                            config.configurations = {
                                {
                                    name = "Launch file",
                                    type = "codelldb",
                                    request = "launch",
                                    program = function()
                                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                                    end,
                                    cwd = "${workspaceFolder}",
                                    stopOnEntry = false,
                                    args = {}
                                }
                            }

                            require("mason-nvim-dap").default_setup(config)
                        end
                    }
                }
            )
        end
    }
}
