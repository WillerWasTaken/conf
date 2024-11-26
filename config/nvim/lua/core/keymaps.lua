vim.g.mapleader = " "

-- Quit
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>")
-- Save
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>")
-- Remove search highlighting
vim.keymap.set("n", "<leader>a", "<cmd>nohl<CR>")

-- Move up and down 'visually' line by line
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Escape with jk
vim.keymap.set("i", "jk", "<Esc>")

-- Vim configuration manipulation
vim.keymap.set("n", "<leader>ce", "<cmd>tabnew<CR>:lcd ~/conf<CR>:e ~/conf/config/nvim/init.lua<CR>")
vim.keymap.set("n", "<leader>cs", "<cmd>source ~/.config/nvim/init.lua<CR>")

-- Diff
vim.keymap.set("n", "<leader>dt", "<cmd>windo diffthis<CR>")
vim.keymap.set("n", "<leader>do", "<cmd>windo diffoff!<CR>")

-- Search under visual
vim.keymap.set("v", "*", "y/\\V<C-r>=escape(@\",'/\\')<CR><CR>")
vim.keymap.set("v", "#", "y?\\V<C-r>=escape(@\",'/\\')<CR><CR>")

-- Quick access to clipboard
vim.keymap.set({"n", "v"}, "<leader>y", "\"+")

-- Move between split
vim.keymap.set("n", "<leader>h", "<C-W>h")
vim.keymap.set("n", "<leader>j", "<C-W>j")
vim.keymap.set("n", "<leader>k", "<C-W>k")
vim.keymap.set("n", "<leader>l", "<C-W>l")
