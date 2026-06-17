vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true

vim.o.relativenumber = true
vim.o.number = true

vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.undofile = true

vim.opt.directory = vim.fn.stdpath("state") .. "/swap//"
vim.opt.updatecount = 100

vim.opt.swapfile = true
vim.opt.backup = false

vim.o.splitright = true
vim.opt.scrolloff = 8
vim.o.incsearch = true
vim.o.ignorecase = false
vim.o.smartcase = true

vim.opt.wrap = false
vim.opt.colorcolumn = "80"

vim.opt.cursorline = true

vim.opt.spelllang = "en_us"
vim.opt.spell = true

vim.opt.expandtab = false
vim.opt.shiftwidth = 2
vim.opt.tabstop = 8
vim.opt.smartindent = true

vim.opt.statusline = "%f%h%m%r%w%=  %y %l,%c | %P | %{strftime('%H:%M')}"

vim.opt.shortmess:append("c")

vim.opt.path = { ".", "**" }
vim.opt.wildignore:append({
	"**/node_modules/**",
	"**/dist/**",
	"**/build/**",
	"**/.git/**",
	"**/.next/**",
	"**/.turbo/**",
	"**/.cache/**",
	"**/coverage/**",
	"**/out/**",
})

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the top window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the bottom window" })

vim.keymap.set("n", "n", "nzzzv", { desc = "center after next search match" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "center after previous search match" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "center after half page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "center after half page up" })

vim.keymap.set("n", "<leader>fd", ":find ", { desc = "Find file" })
vim.keymap.set("n", "<leader>g", ":grep ", { desc = "Grep" })
vim.keymap.set("n", "<leader>l", ":ls<CR>", { desc = "List buffers" })

local highlightGroup = vim.api.nvim_create_augroup("highlight-yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Hightlight when yanking (copying) text",
	group = highlightGroup,
	callback = function()
		vim.highlight.on_yank({ timeout = 80 })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.opt_local.path = { ".", "**" }
	end,
})

require("vim._core.ui2").enable({ enable = true })

vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
	{
		src = "https://github.com/kylechui/nvim-surround",
		name = "Nvim Surround",
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "tsx", "jsx", "typescript", "javascript", "go" },
	callback = function()
		vim.treesitter.start()
	end,
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		go = { "goimports", "gofmt" },
	},

	format_on_save = {
		lsp_fallback = false,
		async = false,
		timeout_ms = 1000,
	},
})

vim.lsp.config("*", {
	root_markers = { ".git" },
})

vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
})

vim.lsp.config("gopls", {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
})

vim.lsp.config("vtsls", {
	cmd = { "vtsls", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
})

vim.lsp.config("marksman", {
	cmd = { "marksman" },
	filetypes = { "markdown" },
})

vim.lsp.config("clangd", {
	cmd = { "clangd" },
	filetypes = { "c", "cpp" },
	root_markers = {
		".git",
		"compile_commands.json",
		"compile_flags.txt",
	},
})

vim.lsp.enable({ "lua_ls", "vtsls", "gopls", "marksman", "clangd" })

local orig_hover = vim.lsp.buf.hover
vim.lsp.buf.hover = function(config)
	config = vim.tbl_deep_extend("force", config or {}, { border = "rounded" })
	orig_hover(config)
end

local orig_sig = vim.lsp.buf.signature_help
vim.lsp.buf.signature_help = function(config)
	config = vim.tbl_deep_extend("force", config or {}, { border = "rounded" })
	orig_sig(config)
end

vim.diagnostic.config({ float = { border = "rounded" } })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLSPConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf, silent = true }
		local keymap = vim.keymap

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
		vim.keymap.set("n", "grr", vim.lsp.buf.references, { desc = "go to references" })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "go to declaration" })
		vim.keymap.set("n", "gi", vim.lsp.buf.type_definition, { desc = "go to type definition" })

		opts.desc = "Add Diagnostic to local list"
		keymap.set("n", "<leader>ql", vim.diagnostic.setqflist, opts)

		opts.desc = "Get Workspace symbols"
		keymap.set("n", "gS", vim.lsp.buf.workspace_symbol, opts)

		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_next()
			vim.diagnostic.open_float()
		end, { desc = "Next diagnostic with float" })

		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_prev()
			vim.diagnostic.open_float()
		end, { desc = "Prev diagnostic with float" })
	end,
})
