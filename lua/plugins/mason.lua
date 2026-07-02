-- lsp配置
return {
    -- 1. 包管理器：mason.nvim
    {
        "mason-org/mason.nvim",
        build = ":MasonUpdate",
        event = "VeryLazy",
        config = function()
            require("mason").setup()
        end,
    },

    -- 2. 桥梁：mason-lspconfig.nvim
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "saghen/blink.cmp",
        },
        event = "VeryLazy",
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            require("mason-lspconfig").setup({
                automatic_installation = false,
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup({
                            capabilities = capabilities,
                        })
                    end,
                    ["lua_ls"] = function() end,
                },
            })
        end,
    },

    -- 3. 格式化工具：conform.nvim
    {
        "stevearc/conform.nvim",
        dependencies = { "mason-org/mason.nvim" },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    c = { "clang-format" },
                    markdown = { "prettier" },
                },
                -- ★ 为 prettier 指定参数，包含文件路径以推断解析器
                formatters = {
                    prettier = {
                        args = {
                            "--stdin-filepath", "$FILENAME", -- 告知文件路径，prettier 自动选择解析器
                            "--tab-width", "4",
                        },
                    },
                },
                format_on_save = false,
            })
        end,
    },

    -- 4. 通用 LSP 配置
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            "stevearc/conform.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            -- 诊断配置
            vim.diagnostic.config({
                virtual_text = true,
                update_in_insert = true,
            })

            -- lua_ls 配置
            vim.lsp.config.lua_ls = {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            }

            -- LSP 按键映射
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local buf = ev.buf
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf })
                    -- <leader>s：优先使用 conform 格式化，若无则回退到 LSP，最后保存
                    vim.keymap.set("n", "<leader>s", function()
                        require("conform").format({
                            async = false,       -- 同步执行，确保格式化完成再保存
                            lsp_fallback = true, -- 若未配置 conform 格式化器，则尝试 LSP 格式化
                        })
                        vim.cmd("write")         -- 保存文件（无论格式化是否执行）
                    end, { buffer = buf, desc = "Format and save" })
                end,
            })
        end,
    },
}
