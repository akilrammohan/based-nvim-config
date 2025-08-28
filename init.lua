vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.wrap = true
vim.o.tabstop = 2
vim.o.termguicolors = true
-- vim.o.timeoutlen = 600
vim.o.scrolloff = 10
vim.o.sidescrolloff = 8

-- move lines up and down - taken from https://github.com/radleylewis/nvim-lite/blob/youtube_demo/init.lua
-- changed to include visual line mode as well
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set({"v", "x"}, "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set({"v", "x"}, "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<leader>o', ':update<CR> :so<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>wq', ':write<CR> :quit<CR>')
vim.keymap.set('n', '<leader>h', ':help ')

-- system clipboard
vim.keymap.set({'n', 'v', 'x'}, '<leader>y', '"+y<CR>')
vim.keymap.set({'n', 'v', 'x'}, '<leader>d', '"+d<CR>')
vim.keymap.set({'n', 'v', 'x'}, '<leader>p', '"+p<CR>')

-- highlight after yanking, from kickstart.nvim
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.keymap.set('n', '<leader>K', ':lua vim.lsp.buf.hover()<CR>')
vim.o.winborder = 'double'

vim.opt.guicursor = table.concat({
	'n-v-c:block',
	'i-ci-ve:ver25-blinkwait700-blinkoff400-blinkon250',
	'r-cr:hor20',
	'o:hor50',
	'sm:block-blinkwait175-blinkoff150-blinkon175'
}, ',')

vim.pack.add({
	{ src = 'https://github.com/vague2k/vague.nvim' },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/stevearc/oil.nvim' },
	{ src = 'https://github.com/mason-org/mason.nvim' },
	{ src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
	{ src = 'https://github.com/chomosuke/typst-preview.nvim' },
})

-- manual update key
vim.keymap.set('n', '<leader>pu', function()
  if vim.pack and vim.pack.update then
    vim.pack.update()
  else
    vim.notify('vim.pack.update() not available (need nightly)', vim.log.levels.WARN)
  end
end, { desc = 'Pack update' })

-- run once on first launch of the day
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local ok, daily = pcall(require, 'pack_daily')
    if ok and daily.maybe_update then daily.maybe_update() end
  end,
})

require 'mason'.setup()
require 'mason-lspconfig'.setup({
	ensure_installed = { 'lua_ls', 'basedpyright', 'vtsls', 'tinymist', 'rust_analyzer' },
	automatic_installation = true
})
vim.lsp.enable({ 'lua_ls' })
vim.lsp.enable({ 'basedpyright' })
vim.lsp.enable({ 'vtsls' })
vim.lsp.enable({ 'tinymist' })
vim.lsp.enable({ 'rust_analyzer' })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

require 'oil'.setup()
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

require 'typst-preview'.setup()
vim.keymap.set('n', '<leader>e', '<CMD>LspTinymistExportPdf<CR>')
vim.keymap.set('n', '<leader>r', '<CMD>TypstPreview<CR>')

vim.cmd('colorscheme vague')
