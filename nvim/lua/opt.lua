local opt = vim.opt

vim.opt.background = "dark"
vim.cmd.colorscheme("catppuccin-macchiato")

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/tmp/vim/undodir"
vim.opt.undofile = true

vim.opt.wrap = false

vim.opt.wildignorecase = true
vim.opt.wildignore = vim.opt.wildignore + "*.so,*.swp,*.zip,*.rar,*.tar.*"

vim.opt.colorcolumn = "100"
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.expandtab = true
  end,
})

vim.opt.autoread = true

vim.opt.listchars = "tab:▸ ,trail:·,eol:¬,nbsp:+"
vim.opt.list = true

vim.opt.scrolloff = 6
vim.opt.signcolumn = yes

vim.opt.updatetime = 600
