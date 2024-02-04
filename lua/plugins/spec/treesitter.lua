local M = {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    dependencies = {
      "lvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
      -- "JoosepAlviste/nvim-ts-context-commentstring",
      -- "windwp/nvim-ts-autotag",
    },
    config = function()
      require("plugins.config.treesitter").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    config = function()
      local ts_context = require("treesitter-context")
      ts_context.setup({
        max_lines = 3,          -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 10, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      })
      vim.keymap.set("n", "[c", function()
        ts_context.go_to_context()
      end, NOREMAP_SILENT("Go to context"))
      vim.keymap.set("n", "<leader>fc", function()
        ts_context.toggle()
      end, NOREMAP_SILENT("toggle function context"))
    end,
  },
  --[[ {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "VeryLazy",
    config = true,
  }, ]]
  --[[   {
    -- https://github.com/windwp/nvim-ts-autotag
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    config = true,
  }, ]]
}

return M
