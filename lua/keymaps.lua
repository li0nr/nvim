-- Only generic keymaps are set here. Most of the other ones are set alongside
-- the corresponding plugin setup.

-- Esc on jk as well
vim.keymap.set("i", "jk", "<Esc>", NOREMAP("Escape using jk"))

-- Purge selection into black hole and paste over it
vim.keymap.set("x", "<leader>p", [["_dP]])
-- just delete selection.
vim.keymap.set("x", "<leader>d", [["_d]])

-- Move lines
-- replaced C [CTRL] with shift to allow tmux navigaiton to work
-- vim.keymap.set("i", "down", "<Esc><Cmd>m .+1<Cr>==gi", { desc = "Move down" })
-- vim.keymap.set("i", "up", "<Esc><Cmd>m .-2<Cr>==gi", { desc = "Move up" })
-- vim.keymap.set("n", "down", "<cmd>m .+1<Cr>==", { desc = "Move down" })
-- vim.keymap.set("n", "up", "<cmd>m .-2<Cr>==", { desc = "Move up" })
-- vim.keymap.set("v", "down", ":m '>+1<Cr>gv=gv", { desc = "Move down" })
-- vim.keymap.set("v", "up", ":m '<-2<Cr>gv=gv", { desc = "Move up" })
-- Mac os specific disabled all other modes just use it in visual mode.
-- vim.keymap.set("i", "˚", "<Esc><Cmd>m .-2<Cr>==gi", { desc = "Move up" })
-- vim.keymap.set("i", "∆", "<Esc><Cmd>m .+1<Cr>==gi", { desc = "Move down" })
--
-- vim.keymap.set("n", "˚", "<cmd>m .-2<Cr>==", { desc = "Move up" })
-- vim.keymap.set("n", "∆", "<cmd>m .+1<Cr>==", { desc = "Move down" })

-- iterm specific ALT-j, ALT-k
-- vim.keymap.set("v", "˚", ":m '<-2<Cr>gv=gv", { desc = "Move up" })
-- vim.keymap.set("v", "∆", ":m '>+1<Cr>gv=gv", { desc = "Move down" })

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move up" })

-- Resize with arrows
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })


-- Remap for dealing with word wrap
vim.keymap.set(
  "n",
  "k",
  "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true }
)
vim.keymap.set(
  "n",
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true }
)

-- Cycle through windows in a tab
-- vim.keymap.set("n", "<Tab>", "<C-W>w", NOREMAP("Next window in tab"))
-- vim.keymap.set("n", "<S-Tab>", "<C-W>W", NOREMAP("Previous window in tab"))

-- When scrolling using CTRL F/D/U, put the screen in center
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set("n", "<leader>nn",  ':set relativenumber!<CR>:highlight LineNr guibg=none guifg=#ffffff<CR>', {noremap = true, silent = true})
-- ============== Quick fix navigations ===================
-- Mapping to disable spelling error highlighting
vim.keymap.set('n', '<Leader>sd', ':hi clear SpellBad<CR>', { noremap = true , silent = true})
-- Mapping to enable spelling error highlighting
vim.keymap.set('n', '<Leader>se', ':hi SpellBad cterm=underline gui=undercurl<CR>', { noremap = true , silent = true  })

vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true })
vim.keymap.set('n', 'n', "nzz", { noremap = true , silent = true  })

vim.keymap.set('n', 'N', "Nzz", { noremap = true, silent = true })

-- Function to copy the file path to the clipboard ===================
local function copy_file_path()
  local file_path = vim.fn.expand('%') -- Relative path to where Neovim was launched
  vim.fn.setreg('+', file_path)        -- Copy to the system clipboard (register '+')
end
-- Map keys to allow for coping file/dir paths.
vim.keymap.set('n', '<leader>cp', copy_file_path, { desc = "Copy file path", noremap = true, silent = true })

-- ============== Quick fix navigations ===================
local function safe_quickfix_nav(cmd, fallback)
  local success = pcall(vim.cmd, cmd)
  if not success then
    vim.cmd(fallback)
  end
end
vim.keymap.set('n', '<A-]>', function()
  safe_quickfix_nav('cnext', 'cfirst')
end, { noremap = true, silent = true, desc = 'Navigate to the next quickfix item' })

vim.keymap.set('n', '<A-[>', function()
  safe_quickfix_nav('cprev', 'clast')
end, { noremap = true, silent = true, desc = 'Navigate to the previous quickfix item' })

-- },
-- ========================== Tabs ==========================
local function tab_prefix(desc)
  return "Tabs: " .. desc
end
-- Tab navigation
vim.keymap.set("n", "]t", ":tabn<CR>", { desc = tab_prefix("→ Navigate Right") })
vim.keymap.set("n", "[t", ":tabp<CR>", { desc = tab_prefix("← Navigate Left") })
-- Leader-based tab management
vim.keymap.set("n", "<leader>tn", ":$tabnew<CR>", { desc = tab_prefix("new Tab") })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = tab_prefix("close Tab") })
vim.keymap.set("n", "<leader>th", ":tabp<CR>", { desc = tab_prefix("← Navigate Left") })
vim.keymap.set("n", "<leader>tl", ":tabn<CR>", { desc = tab_prefix("→ Navigate Right") })
vim.keymap.set("n", "<leader>tk", ":+tabmove<CR>", { desc = tab_prefix("↜ Move to Prev") })
vim.keymap.set("n", "<leader>tj", ":-tabmove<CR>", { desc = tab_prefix("↝ Move to Next") })
