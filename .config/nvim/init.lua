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

vim.api.nvim_set_hl(0, "Normal", { bg = "#16181d" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1c1f26" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#3d4250", bg = "#1c1f26" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "typescriptreact" },
	callback = function()
		vim.bo.omnifunc = "javascriptcomplete#CompleteJS"
	end,
})

vim.pack.add({
	{
		src = "https://github.com/ibhagwan/fzf-lua",
	},
	-- {
	-- 	src = "https://github.com/nvim-treesitter/nvim-treesitter",
	-- },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{
		src = "https://github.com/kylechui/nvim-surround",
		name = "Nvim Surround",
	},
	{ src = "https://github.com/mason-org/mason.nvim", name = "Mason" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/Saghen/blink.lib" },
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
	{ src = "https://github.com/neanias/everforest-nvim" },
	{ src = "https://github.com/oskarnurm/koda.nvim" },
})

vim.cmd.colorscheme("default")

vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })

-- vim.api.nvim_set_hl(0, "@comment", {
-- 	fg = "#5f5f5f",
-- 	italic = false,
-- 	bg = "NONE",
-- })

vim.api.nvim_set_hl(0, "Type", { fg = "#8f9bb3" })
vim.api.nvim_set_hl(0, "Function", { fg = "#c8d0e0" })
vim.api.nvim_set_hl(0, "Statement", { fg = "#a0a8b8" })
vim.api.nvim_set_hl(0, "Comment", { fg = "#6a7280", italic = true })
vim.api.nvim_set_hl(0, "PreProc", { fg = "#b8a070" })

-- vim.api.nvim_set_hl(0, "Type", { fg = "#c0a080" })
-- vim.api.nvim_set_hl(0, "Function", { fg = "#d0c0a0" })
-- vim.api.nvim_set_hl(0, "Statement", { fg = "#b8a890" })
-- vim.api.nvim_set_hl(0, "Comment", { fg = "#70685f", italic = true })
-- vim.api.nvim_set_hl(0, "PreProc", { fg = "#d0b070" })

-- vim.api.nvim_set_hl(0, "Type", { fg = "#7f9db9" })
-- vim.api.nvim_set_hl(0, "Function", { fg = "#b7c9d6" })
-- vim.api.nvim_set_hl(0, "Statement", { fg = "#95a5b3" })
-- vim.api.nvim_set_hl(0, "Comment", { fg = "#66707a", italic = true })
-- vim.api.nvim_set_hl(0, "PreProc", { fg = "#b39d6b" })

vim.opt.signcolumn = "no"

local conform = require("conform")

conform.setup({
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

vim.lsp.enable({ "lua_ls", "vtsls", "gopls", "marksman" })

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
		local blink = require("blink.cmp")
		blink.setup({
			completion = {
				trigger = {
					show_on_insert = true,
					show_on_keyword = true,
					show_on_trigger_character = true,
					show_on_backspace = true,
					show_on_backspace_in_keyword = true,
					show_on_backspace_after_accept = true,
					show_on_backspace_after_insert_enter = true,
					show_on_accept_on_trigger_character = true,
					show_on_insert_on_trigger_character = true,
				},
				menu = {
					border = "rounded",
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
				},
				documentation = {
					window = { border = "rounded" },
				},
			},
			sources = {
				default = { "lsp", "buffer" },
			},
			keymap = {
				preset = "enter",
				["<C-Space>"] = { "show", "hide" },
				["<C-n>"] = { "select_next" },
				["<C-p>"] = { "select_prev" },
				["<C-y>"] = { "select_and_accept" },
				["<C-e>"] = { "hide" },
				["<C-b>"] = { "scroll_documentation_up" },
				["<C-f>"] = { "scroll_documentation_down" },
			},
		})

		local opts = { buffer = ev.buf, silent = true }
		local keymap = vim.keymap

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
		vim.keymap.set("n", "gi", vim.lsp.buf.type_definition, { desc = "go to type definition" })

		vim.keymap.set("n", "grd", vim.diagnostic.open_float, { desc = "Open diagnostic float" })

		opts.desc = "Add Diagnostic to local list"
		keymap.set("n", "gql", vim.diagnostic.setqflist, opts)

		local fzf = require("fzf-lua")

		fzf.setup({
			winopts = {
				height = 0.80,
				width = 0.70,
				row = 0.35,
				col = 0.50,
				border = "rounded",
				preview = {
					layout = "horizontal",
					horizontal = "down:60%",
				},
			},
			hls = { border = "FloatBorder" },
		})

		require("fzf-lua").register_ui_select({
			silent = true,
		})

		vim.keymap.set({ "n", "v", "i" }, "<C-x><C-f>", function()
			FzfLua.complete_path()
		end, { silent = true, desc = "Fuzzy complete path" })

		vim.keymap.set("n", "<C-p>", function()
			FzfLua.files()
		end, { silent = true, desc = "Fuzzy complete path" })

		vim.keymap.set("n", "g/", function()
			FzfLua.live_grep_native()
		end, { silent = true, desc = "Fuzzy complete path" })

		vim.keymap.set("n", "gS", function()
			FzfLua.lsp_live_workspace_symbols()
		end, { silent = true, desc = "Fuzzy complete path" })

		vim.keymap.set("n", "grr", function()
			FzfLua.lsp_references()
		end, { silent = true, desc = "Fuzzy complete path" })

		vim.keymap.set("n", "gra", function()
			FzfLua.lsp_code_actions()
		end, { silent = true, desc = "Fuzzy complete path" })

		vim.keymap.set("n", "gO", function()
			FzfLua.lsp_document_symbols()
		end, { silent = true, desc = "Fuzzy complete path" })

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

local ms = require("mason")
ms.setup()
