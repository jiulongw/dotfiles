-- Telescope
do
  local builtin = require("telescope.builtin")
  vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
  vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
  vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
  vim.keymap.set("n", "<leader>ft", builtin.git_files, {})

  vim.keymap.set("n", "<leader>fw", function()
    builtin.grep_string({ search = vim.fn.expand("<cword>") })
  end)
end


vim.keymap.set("n", "-", vim.cmd.Ex)
vim.keymap.set("x", "<leader>p", "\"_dP")


-- Move selected lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })


-- Map copy and paste with system clipboard register
vim.keymap.set("n", "<C-y>", "\"+y")
vim.keymap.set("v", "<C-y>", "\"+y")
vim.keymap.set("n", "<C-p>", "\"+p")
vim.keymap.set("v", "<C-p>", "\"+p")
vim.keymap.set("n", "Y", "y$")


-- Cope
vim.keymap.set("n", "<leader>co", ":botright cope<cr>")
vim.keymap.set("n", "<leader>cn", ":cn<cr>")
vim.keymap.set("n", "<leader>cp", ":cp<cr>")
vim.keymap.set("n", "<leader>cc", ":cclose<cr>")


-- Switch to recent buffer
vim.keymap.set("n", "<leader>b", ":b#<cr>", { noremap = true, silent = true })


-- Full path to system clipboard
vim.keymap.set("n", "<leader>yp", ":let @+ = expand(\"%:p\")<CR>", { noremap = true, silent = true })


-- Cmd+c / Cmd+v in Neovide
if vim.g.neovide then
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<C-R>+') -- Paste insert mode
end


-- Plugins
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
