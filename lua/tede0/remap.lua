local set = vim.keymap.set
vim.g.mapleader = " "


-- Filetree
set("n", "-", "<CMD>Oil<CR>")

-- Navigation
set("n", "<C-h>", "<C-w>h")
set("n", "<C-l>", "<C-w>l")
set("n", "<C-j>", "<C-w>j")
set("n", "<C-k>", "<C-w>k")

-- Terminal
set("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Toggle terminal" })
set("t", "<C-q>", "<cmd>close<CR>", { desc = "Close terminal" })

-- Move block of code
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- Ease of use
set("n", "<leader>vs", "<C-w>v")      -- vertical split
set("n", "<leader>hs", "<C-w>s")      -- horizontal split
set("n", "<leader>x", "<cmd> x <CR>") -- close buffer

-- Tabs
set("n", "<leader>tt", "<cmd>tabnew<CR>")
set("n", "<TAB>", "gt")
set("n", "<S-TAB>", "gT")

set("n", "J", "mzJ`z")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

set("n", "<Esc>", "<CMD> noh <CR>")                                           -- clear highlights
set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- rename

set("x", "<leader>p", [["_dP]])

set({ "n", "v" }, "<leader>y", [["+y]])
set("n", "<leader>Y", [["+Y]])

set({ "n", "v" }, "<leader>d", [["_d]])
