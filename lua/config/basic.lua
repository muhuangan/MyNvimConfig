-- *.h 识别为 C 而不是 C++（Neovim 的文件类型检测会读取该变量）
vim.g.c_syntax_for_h = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.expandtab = true

vim.opt.autoread = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.showmode = false
