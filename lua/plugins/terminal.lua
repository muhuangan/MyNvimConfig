-- 终端
return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
        { "<C-t>", ":ToggleTerm<CR>", desc = "Toggle terminal" }, -- 按 Ctrl+t 时加载插件
    },
    config = function()
        require("toggleterm").setup({
            size = 10,
            open_mapping = [[<C-t>]],
            direction = "horizontal",
            start_in_insert = true,
            close_on_exit = true,
            shade_terminals = true,
            shading_factor = 2,
            hide_numbers = true,
            persist_size = true,
            shell = "fish",
        })
    end,
}
