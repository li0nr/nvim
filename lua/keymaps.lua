-- Only generic keymaps are set here. Most of the other ones are set alongside
-- the corresponding plugin setup.

-- Esc on jk as well
vim.keymap.set("i", "jk", "<Esc>", NOREMAP("Escape using jk"))

-- Purge selection into black hole and paste over it
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Move lines
-- replaced C [CTRL] with shift to allow tmux navigaiton to work
vim.keymap.set("i", "<C-j>", "<Esc><Cmd>m .+1<Cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<C-k>", "<Esc><Cmd>m .-2<Cr>==gi", { desc = "Move up" })
vim.keymap.set("n", "<S-j>", "<cmd>m .+1<Cr>==", { desc = "Move down" })
vim.keymap.set("n", "<S-k>", "<cmd>m .-2<Cr>==", { desc = "Move up" })
vim.keymap.set("v", "<S-j>", ":m '>+1<Cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<S-k>", ":m '<-2<Cr>gv=gv", { desc = "Move up" })

-- Resize with arrows
vim.keymap.set(
  "n",
  "<C-Up>",
  "<Cmd>resize -4<Cr>",
  NOREMAP("Resize window ⬆️ by 4")
)
vim.keymap.set(
  "n",
  "<C-Down>",
  "<Cmd>resize +4<Cr>",
  NOREMAP("Resize window ⬇️ by 4")
)
vim.keymap.set(
  "n",
  "<C-Left>",
  "<Cmd>vertical resize -4<Cr>",
  NOREMAP("Resize window ⬅️ by 4")
)
vim.keymap.set(
  "n",
  "<C-Right>",
  "<Cmd>vertical resize +4<Cr>",
  NOREMAP("Resize window ➡️ by 4")
)

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
-- Mapping to disable spelling error highlighting
vim.keymap.set('n', '<Leader>ds', ':hi clear SpellBad<CR>', { noremap = true , silent = true})

-- Mapping to enable spelling error highlighting
vim.keymap.set('n', '<Leader>es', ':hi SpellBad cterm=underline gui=undercurl<CR>', { noremap = true , silent = true  })

vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true })
