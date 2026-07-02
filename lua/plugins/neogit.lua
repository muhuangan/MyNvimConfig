-- 交互式git体验
return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    config = function()
        local neogit = require("neogit")
        neogit.setup({
            graph_style = "kitty",
        })
    end
}
