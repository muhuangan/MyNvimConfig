-- 查找器
return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && "
                .. "cmake --build build --config Release && "
                .. "cmake --install build --prefix build",
        },
        "nvim-telescope/telescope-project.nvim",
        {
            "nvim-telescope/telescope-frecency.nvim",
            dependencies = { "kkharji/sqlite.lua" },
        },
    },

    cmd = "Telescope",
    keys = {
        { "<leader>t", "<cmd>lua require('user.telescope').custom_menu()<CR>", desc = "Telescope menu" },
    },

    opts = {
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
            frecency = {
                auto_validate = true,
                show_scores = false,
                show_unindexed = true,
                ignore_patterns = { "*.git/*", "*/tmp/*", "*/node_modules/*" },
                workspaces = {
                    ["main"] = {
                        path = vim.fn.expand("~/Projects"),
                        max_size = 100,
                        min_score = 0,
                    },
                },
            },
            project = {
                base_dirs = { vim.fn.expand("~/Projects") },
                hidden_files = false,
                theme = "dropdown",
                order_by = "recent",
                search_by = "title",
                sync_with_nvim_tree = false,
            },
        },
    },

    config = function(_, opts)
        local telescope = require("telescope")
        telescope.setup(opts)
        telescope.load_extension("fzf")
        telescope.load_extension("frecency")
        telescope.load_extension("project")

        local function custom_menu()
            local actions = require("telescope.actions")
            local finders = require("telescope.finders")
            local pickers = require("telescope.pickers")
            local conf = require("telescope.config").values
            local action_state = require("telescope.actions.state")

            local items = {
                { "Neogit",       "neogit" },
                { "Find Files",   "fd" },
                { "Live Grep",    "live_grep" },
                { "Git Status",   "git_status" },
                { "Project",      "project" },
                { "Recent Files", "frecency" },
            }

            pickers.new({}, {
                prompt_title = "Telescope Menu",
                finder = finders.new_table {
                    results = items,
                    entry_maker = function(entry)
                        return {
                            value = entry,
                            display = entry[1],
                            ordinal = entry[1],
                        }
                    end,
                },
                sorter = conf.generic_sorter({}),
                attach_mappings = function(prompt_bufnr, map)
                    map("i", "<CR>", function()
                        local selection = action_state.get_selected_entry(prompt_bufnr)
                        if not selection then
                            return
                        end
                        local name = selection.value[2]
                        actions.close(prompt_bufnr)

                        if name == "project" then
                            require("telescope").extensions.project.project()
                        elseif name == "frecency" then
                            require("telescope").extensions.frecency.frecency()
                        elseif name == "neogit" then
                            vim.cmd("Neogit")
                        else
                            local builtin = require("telescope.builtin")
                            if builtin[name] then
                                builtin[name]()
                            else
                                vim.notify("Picker not found: " .. name, vim.log.levels.WARN)
                            end
                        end
                    end, { desc = "Select" })
                    return true
                end,
            }):find()
        end

        local user_telescope = {}
        user_telescope.custom_menu = custom_menu
        package.loaded['user.telescope'] = user_telescope
    end,
}
