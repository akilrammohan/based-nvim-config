vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.timeoutlen = 600

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>o", ":update<CR> :so<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")
vim.keymap.set("n", "<leader>wq", ":write<CR> :quit<CR>")
vim.keymap.set("n", "<leader>h", ":help ")

vim.keymap.set("n", "<leader>K", ":lua vim.lsp.buf.hover()<CR>")
vim.o.winborder = "double"

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
})

require "mason".setup()
require "mason-lspconfig".setup({
	ensure_installed = { "lua_ls", "basedpyright", "vtsls" },
	automatic_installation = true
})
vim.lsp.enable({ "lua_ls" })
vim.lsp.enable({ "basedpyright" })
vim.lsp.enable({ "vtsls" })
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)

require "oil".setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.opt.guicursor = table.concat({
	"n-v-c:block",
	"i-ci-ve:ver25-blinkwait700-blinkoff400-blinkon250",
	"r-cr:hor20",
	"o:hor50",
	"sm:block-blinkwait175-blinkoff150-blinkon175"
}, ",")
vim.cmd("colorscheme vague")
