-- 侧边栏
return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>o", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
    },
    opts = {
        actions = {
            open_file = {
                quit_on_open = true, -- 打开文件后自动关闭树
            },
        },
        filters = {
            dotfiles = true, -- 显示隐藏文件（以 . 开头的文件）
        },
    },
}
