-- 语法解析器
return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        -- 1. 标准配置：高亮 + 缩进
        require("nvim-treesitter.config").setup({
            ensure_installed = { "c", "lua" },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
        })

        -- 2. 兜底：确保解析器已安装并启动高亮
        local nvim_treesitter = require("nvim-treesitter")
        local ensure_installed = { "c", "lua" }
        local pattern = {}

        for _, parser in ipairs(ensure_installed) do
            local has_parser, _ = pcall(vim.treesitter.language.inspect, parser)
            if not has_parser then
                nvim_treesitter.install(parser)
            else
                pattern = vim.tbl_extend("keep", pattern, vim.treesitter.language.get_filetypes(parser))
            end
        end

        -- 对已安装解析器的文件类型，手动启动高亮
        vim.api.nvim_create_autocmd("FileType", {
            pattern = pattern,
            callback = function()
                vim.treesitter.start()
            end,
        })
    end,
}
