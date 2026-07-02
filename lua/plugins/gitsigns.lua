-- lua/plugins/gitsigns.lua
return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
        require("gitsigns").setup({
            -- 在行号区域显示变更符号（保留，便于观察改动）
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            -- ★ 开启当前行的 Blame 信息（自动显示）
            current_line_blame = true,
            -- 自定义 Blame 显示样式
            current_line_blame_opts = {
                delay = 500,      -- 延迟半秒显示，避免光标移动时闪烁
                virt_text = true, -- 使用虚拟文本显示（直接在行尾显示信息）
            },
        })

        -- ★ 只保留一个手动 Blame 快捷键（按需查看完整信息）
        vim.keymap.set("n", "<leader>gb", function()
            require("gitsigns").blame_line()
        end, { desc = "Git Blame current line" })
    end,
}
