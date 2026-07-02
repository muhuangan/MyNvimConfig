-- cmake工具
return {
    "Civitasv/cmake-tools.nvim",
    cmd = {
        -- 核心构建
        "CMakeGenerate", "CMakeBuild", "CMakeClean", "CMakeInstall",
        "CMakeRun", "CMakeRunTest", "CMakeDebug",
        -- 目标相关
        "CMakeBuildCurrentFile", "CMakeRunCurrentFile", "CMakeDebugCurrentFile",
        -- 选择
        "CMakeSelectBuildType", "CMakeSelectBuildTarget", "CMakeSelectLaunchTarget",
        "CMakeSelectKit", "CMakeSelectBuildDir", "CMakeSelectCwd",
        "CMakeSelectConfigurePreset", "CMakeSelectBuildPreset", "CMakeSelectTestPreset",
        -- 预设与设置
        "CMakeTargetSettings", "CMakeSettings",
        -- 快速
        "CMakeQuickBuild", "CMakeQuickRun", "CMakeQuickStart",
        -- 参数与文件
        "CMakeLaunchArgs", "CMakeShowTargetFiles", "CMakeOpenCache",
        -- 窗口管理
        "CMakeOpenExecutor", "CMakeCloseExecutor", "CMakeStopExecutor",
        "CMakeOpenRunner", "CMakeCloseRunner", "CMakeStopRunner",
    },
    dependencies = {
        "akinsho/toggleterm.nvim",
    },
    config = function()
        require("cmake-tools").setup({
            cmake_build_directory = "build",
            cmake_runner = {
                name = "toggleterm",
                opts = {
                    direction = "horizontal",
                    size = 15,
                    close_on_exit = false,
                },
            },
        })
    end,
}
