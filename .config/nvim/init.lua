require("config.lazy")
require("config.lsp")
require("config.dap")

require("treesitter-context").setup({
    enable = false
})

-- Disable comment continuation by default
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

vim.o.termguicolors = true
vim.cmd [[colorscheme tokyonight-night]]

vim.opt.tabstop = 4
vim.opt.colorcolumn = "80"
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.smartindent = true
vim.o.number = true
vim.o.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.o.showmode = false
vim.o.breakindent = true
vim.o.undofile = true
vim.o.scrolloff = 8
vim.o.confirm = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>pv', '<cmd>Ex<CR>')
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end)
vim.keymap.set('n', '<leader>do', function() require('dap').step_over() end)
vim.keymap.set('n', '<leader>di', function() require('dap').step_into() end)
vim.keymap.set('n', '<leader>du', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>dt', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set('n', '<Leader>dq',
    function()
        require('dap').terminate()
        require("dapui").close()
        require("nvim-dap-virtual-text").toggle()
    end)
