-- Doxygen 注释生成
-- 递归查找节点下最后一个 type_identifier。
-- neogen 自带的 C 配置只取 struct 标签，遇到 typedef struct {...} Name; 这种
-- 匿名结构体会取不到名字，这里改为取 typedef 的别名。
local function last_type_identifier(node)
    local found
    for child in node:iter_children() do
        if child:type() == "type_identifier" then
            found = child
        else
            found = last_type_identifier(child) or found
        end
    end
    return found
end

return {
    "danymat/neogen",
    keys = {
        {
            "<leader>nf",
            function()
                require("neogen").generate({ type = "func" })
            end,
            desc = "生成函数注释",
        },
        {
            "<leader>nt",
            function()
                require("neogen").generate({ type = "type" })
            end,
            desc = "生成类型注释",
        },
    },
    config = function()
        local i = require("neogen.types.template").item

        require("neogen").setup({
            -- 使用 Neovim 内置 vim.snippet，配合 blink.cmp 的 super-tab 预设跳转占位符
            snippet_engine = "nvim",
            languages = {
                c = {
                    data = {
                        type = {
                            ["type_definition"] = {
                                -- 禁用默认的 struct 标签提取
                                ["1"] = { extract = function() return {} end },
                                -- 改为取最后一个 type_identifier，即 typedef 的别名
                                ["0"] = {
                                    extract = function(node)
                                        local name = last_type_identifier(node)
                                        return name and { [i.Type] = { vim.treesitter.get_node_text(name, 0) } } or {}
                                    end,
                                },
                            },
                        },
                    },
                },
            },
        })
    end,
}
