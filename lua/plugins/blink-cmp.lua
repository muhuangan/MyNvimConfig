-- 补全引擎：blink.cmp
return {
    {
        "saghen/blink.cmp",
        version = "*",
        event = { "InsertEnter", "CmdlineEnter" }, -- 进入插入模式和命令行模式时加载
        dependencies = {
            "rafamadriz/friendly-snippets",
        },

        opts = {
            -- 键位映射预设：super-tab
            keymap = {
                preset = "super-tab",
            },
            completion = {
                documentation = {
                    auto_show = true,
                }
            },

            -- 外观设置
            appearance = {
                nerd_font_variant = "mono",
            },

            -- 补全源设置
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },

            -- 模糊匹配实现
            fuzzy = {
                implementation = "prefer_rust_with_warning",
            },
            cmdline = {
                sources = function()
                    local cmd_type = vim.fn.getcmdtype()
                    if cmd_type == "/" or cmd_type == "?" then
                        return { "buffer" }
                    end
                    if cmd_type == ":" then
                        return { "cmdline" }
                    end
                    return {}
                end,
                keymap = {
                    preset = "super-tab",
                },
                completion = {
                    menu = {
                        auto_show = true
                    }
                }
            }
        },
        opts_extend = { "sources.default" },
    },
}
