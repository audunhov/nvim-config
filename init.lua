vim.o.tabstop = 2
vim.o.cursorcolumn = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.incsearch = true
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.o.mouse = "a"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set
map('n', '<leader>x', ':update<CR> :source<CR>')
map('n', '<leader>lf', vim.lsp.buf.format)

map('n', '<leader>f', ":Pick files<CR>")
map('n', '<leader>h', ":Pick help<CR>")
map('n', '<leader>e', ":Oil<CR>")

map('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.pack.add({
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = 'main' },
	{ src = "https://github.com/catppuccin/nvim" },
})
vim.cmd("colorscheme catppuccin")
vim.cmd("hi statusline guibg=NONE")

require "mini.pick".setup()
require "oil".setup()
require "nvim-treesitter.configs".setup({
	ensure_installed = {"lua", "go"},
	highlight = { enable = true }
})

vim.lsp.enable({ "lua_ls", "html", "gopls" })


vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
