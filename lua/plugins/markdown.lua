return {
    -- 1. 预览插件：markdown-preview.nvim
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = "cd app && npm install",
        config = function()
            -- 基础配置
            vim.g.mkdp_auto_close = 0   -- 切换文件时不关闭预览
            vim.g.mkdp_refresh_slow = 0 -- 实时刷新
            vim.g.mkdp_theme = "light"

            -- 自动启动预览（通过 FileType 自动命令）
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function()
                    local preview_open = vim.fn.exists("g:mkdp_preview_window") == 1
                    if not preview_open then
                        vim.cmd("MarkdownPreview")
                    end
                end,
                desc = "Auto-start Markdown preview",
            })
        end,
    },

    -- 2. TOC 插件：markdown-toc.nvim
    {
        "hedyhli/markdown-toc.nvim",
        ft = "markdown",
        opts = {
            auto_update = true, -- 保存文件时自动更新目录
            fences = {
                enabled = true,
                start_text = "toc-start",
                end_text = "toc-end",
            },
            link = { style = "gfm" }, -- GFM 风格链接
            max_depth = 6,            -- 目录最大层级
            -- 设置缩进为 4 空格
            toc_list = {
                indent_size = 4,
            },
        },
        config = function(_, opts)
            local mtoc = require("mtoc")
            mtoc.setup(opts)
        end,
    },
}
