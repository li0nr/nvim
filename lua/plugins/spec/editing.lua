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
      -- maybe move all mini stuff onto seprate file
      require("mini.files").setup({
        vim.keymap.set("n", "<leader>o", function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end, { desc = "Open mini.files (Directory of Current File)" }),

        -- Module mappings created only inside explorer.
        -- Use `''` (empty string) to not create one.
        mappings = {
          close       = 'q',
          go_in       = 'n',
          go_in_plus  = 'N',
          go_out      = 'p',
          go_out_plus = 'P',
          mark_goto   = "'",
          mark_set    = 'm',
          reset       = '<BS>',
          reveal_cwd  = '@',
          show_help   = 'g?',
          synchronize = 's',
          trim_left   = '<',
          trim_right  = '>',
        },
      })
    end
  },
}

-- removed for mini
-- https://github.com/kylechui/nvim-surround
-- https://github.com/numToStr/Comment.nvim
return M
