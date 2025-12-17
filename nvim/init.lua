vim.opt.number = true
vim.opt.relativenumber = true
vim.g.mapleader = ' '

vim.diagnostic.config({ virtual_text = true })

vim.pack.add{
  { src = "https://github.com/neovim/nvim-lspconfig"},
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/saghen/blink.cmp" },
  { src = "https://github.com/rebelot/kanagawa.nvim" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/numToStr/Comment.nvim"},
  { src = "https://github.com/sphamba/smear-cursor.nvim"},
  { src = "https://github.com/ThePrimeagen/harpoon"},
  { src = "https://github.com/mbbill/undotree"},
  { src = "https://github.com/christoomey/vim-tmux-navigator"},
  { src = "https://github.com/vimpostor/vim-tpipeline"},
  { src = "https://github.com/nvim-mini/mini.surround"},
  { src = "https://github.com/wansmer/treesj"},
  { src = "https://github.com/abecodes/tabout.nvim"},
  { src = "https://github.com/folke/flash.nvim"},
  { src = "https://github.com/brenton-leighton/multiple-cursors.nvim"},
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

require("nvim-ts-autotag").setup {}
require("nvim-autopairs").setup {}

require('nvim-treesitter.configs').setup {
  ensure_installed = {
	"html",
        "css",
	"lua",
        "typescript",
        "python",
        "c",
        "bash",
        "lua",
      },
}

vim.cmd("colorscheme kanagawa")

local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact'}

local ts_ls_config = {
  filetypes = tsserver_filetypes,
}

vim.lsp.config('ts_ls', ts_ls_config)
vim.lsp.config('pyright', {}) 
vim.lsp.enable({'ts_ls', 'pyright'})


require("blink.cmp").setup{
  keymap = { preset = 'super-tab' }
}

-- Formatter --
require("conform").setup({
  formatters_by_ft = {
    python = { "black" },
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

-- Navigation --
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>wv', ':vsplit<CR><C-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>wh', ':split<CR><C-w>j',  { noremap = true, silent = true })
vim.keymap.set('n', '<leader>wq', ':close<CR>', { noremap = true, silent = true })

-- Other --
vim.keymap.set({"n", "v"}, "<leader>y", '"+y', { noremap = true, silent = true })

require("Comment").setup()
require("smear_cursor").toggle()

-- Harpoon -- 
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)
vim.keymap.set("n", "<leader>5", function() ui.nav_file(5) end)
vim.keymap.set("n", "<leader>6", function() ui.nav_file(6) end)

-- Undotree --
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- Other --
require('mini.surround').setup()
require('treesj').setup()
require('tabout').setup()

-- Word Navigation --
local flash = require("flash")
flash.setup()

vim.keymap.set({ "n", "x", "o" }, "zk", flash.jump, { desc = "flash" })

-- Multi Cursor --
require('multiple-cursors').setup()
vim.keymap.set({ "n", "i", "x" }, "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", {
  desc = "Add cursor and move up",
})

vim.keymap.set({ "n", "i", "x" }, "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", {
  desc = "Add cursor and move down",
})

vim.keymap.set({ "n", "i" }, "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", {
  desc = "Add or remove cursor",
})

-- Tree --
vim.g.netrw_winsize = 20
vim.keymap.set("n", "<leader>e", ":Lexplore<CR>", { noremap = true, silent = true })
