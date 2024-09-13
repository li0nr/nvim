-- Only generic keymaps are set here. Most of the other ones are set alongside
-- the corresponding plugin setup.

-- Esc on jk as well
vim.keymap.set("i", "jk", "<Esc>", NOREMAP("Escape using jk"))

-- Purge selection into black hole and paste over it
vim.keymap.set("x", "<leader>p", [["_dP]])
-- just delete secltion.
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

-- mac os specific ALT-j, ALT-k
vim.keymap.set("v", "˚", ":m '<-2<Cr>gv=gv", { desc = "Move up" })
vim.keymap.set("v", "∆", ":m '>+1<Cr>gv=gv", { desc = "Move down" })

-- Resize with arrows
vim.keymap.set(
    "n",
    "–", --<M-->",
    "<Cmd>resize -4<Cr>",
  NOREMAP("Resize window up by 4")
)
vim.keymap.set(
  "n",
  "≠", --<M-=>",
    "<Cmd>resize +4<Cr>",
  NOREMAP("Resize window down by 4")
)
vim.keymap.set(
  "n",
  "‘", --"<M-h>",
  "<Cmd>vertical resize -4<Cr>",
  NOREMAP("Resize window left by 4")
)
vim.keymap.set(
  "n",
  "“", --"<M-Right>",
  "<Cmd>vertical resize +4<Cr>",
  NOREMAP("Resize window right by 4")
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
vim.keymap.set('n', '<Leader>sd', ':hi clear SpellBad<CR>', { noremap = true , silent = true})

-- Mapping to enable spelling error highlighting
vim.keymap.set('n', '<Leader>se', ':hi SpellBad cterm=underline gui=undercurl<CR>', { noremap = true , silent = true  })

vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true })
vim.keymap.set('n', 'n', "nzz", { noremap = true , silent = true  })

vim.keymap.set('n', 'N', "Nzz", { noremap = true , silent = true  })
