vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true
vim.cmd.colorscheme "catppuccin"

vim.opt.tabstop = 4    
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.api.nvim_command("augroup custom_cursor")
vim.api.nvim_command("autocmd!")
vim.api.nvim_command("autocmd InsertEnter * set guicursor=n-v-c:block-Cursor/lCursor,i-ci:ver25-Cursor/lCursor")
vim.api.nvim_command("autocmd InsertLeave * set guicursor=n-v-c:block-Cursor/lCursor,i-ci:ver25-Cursor/lCursor")
vim.api.nvim_command("augroup END")
-- vim.opt.clipboard = "unnamedplus" 

