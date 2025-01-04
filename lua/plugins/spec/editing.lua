local M = {
  {
    -- https://github.com/farmergreg/vim-lastplace
    "farmergreg/vim-lastplace",
  },
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      require('mini.comment').setup()
      require('mini.ai').setup()
      require('mini.surround').setup()
      require("mini.pairs").setup({
        mappings = {
          ["`"] = false,
        },
      })
    end
  },
}

-- removed for mini
-- https://github.com/kylechui/nvim-surround
-- https://github.com/numToStr/Comment.nvim
return M
