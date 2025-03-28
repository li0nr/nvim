--[[===========================================================================
Neovim automatically adds a 'lua' folder, if present here, to be available in
vim's runtimepath. This allows us to import the files and folders in the `lua`
directory as lua modules as we're doing below.

We also don't need to refer to them by their full path which includes '.lua',
we can omit the extension. This is standard lua setup.

On top of this, we can also `require` a folder as long as it has an 'init.lua'
inside the folder. Its the job of that 'init.lua' file to 'require' any other
sub-modules inside the folder.
--]]
-------------------------------------------------------------------------------

require("globals")
-------------------------------------------------------------------------------

--  Leader must be set before plugins are required (otherwise wrong leader will
--  be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-------------------------------------------------------------------------------

-- https://github.com/folke/lazy.nvim?tab=readme-ov-file#-installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins.spec")
-------------------------------------------------------------------------------
require("options")
require("keymaps")
require("autocommands")
require("post")

-------------------------------------------------------------------------------
-- couple of more notes the lua folder is searched in by lua by default.
-- the plugins on the other hand is also added to runtimepath of lua and that's
-- why it is not needed to be required  here.
-- for more info :h runtimepath.
--
--
--https://github.com/hedyhli/outline.nvim 
--https://github.com/ubaldot/vim-outline
--https://github.com/rebelot/kanagawa.nvim?tab=readme-ov-file 
--https://github.com/nanozuki/tabby.nvim
--https://github.com/LukasPietzschmann/telescope-tabs
--https://github.com/ggandor/leap.nvim
--https://github.com/jinh0/eyeliner.nvim
--https://github.com/tpope/vim-repeat
--https://github.com/akinsho/toggleterm.nvim
----https://github.com/folke/trouble.nvim

--
--https://github.com/kylechui/nvim-surround replaced with mini.nvim stuff
--https://github.com/numToStr/Comment.nvim
--https://github.com/windwp/nvim-autopairs
--https://github.com/stevearc/oil.nvim
--https://github.com/RRethy/vim-illuminate
--https://github.com/folke/twilight.nvim
--https://github.com/folke/zen-mode.nvim -- goes will with twilight

