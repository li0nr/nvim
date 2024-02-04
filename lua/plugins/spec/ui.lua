local M = {
  {
    "nvim-lualine/lualine.nvim", -- status line
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        sections = { lualine_c = { { 'filename', path = 1, } } },
      })
    end,
  },
  -- {
  --   "stevearc/dressing.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("dressing").setup({
  --       input = {
  --         enabled = true,
  --         default_prompt = "Input> ",
  --       },
  --     })
  --   end,
  -- },
}

return M
