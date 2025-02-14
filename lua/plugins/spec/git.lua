
local M = {
  {
    -- https://github.com/tpope/vim-fugitive
    "tpope/vim-fugitive",
  },
  {
    -- https://github.com/lewis6991/gitsigns.nvim
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("gitsigns").setup()
    end,
  },
}

return M
