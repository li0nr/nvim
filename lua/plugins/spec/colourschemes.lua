--[[
There has to be a better way to pick a colorscheme. I would like to just
specify the colorscheme, which in turn would just make all the other ones be
loaded very lazily.
--]]

local M = {
  {
    "catppuccin/nvim",
    -- event = "VeryLazy",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        dim_inactive = {
          enabled = true,
        },
        styles = {
          comments = { "italic" },
        },
        integrations = {
          headlines = true,
          indent_blankline = {
            enabled = true,
            scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
            colored_indent_levels = true,
          },
          leap = true,
          symbols_outline = true,
          lsp_trouble = true,
          illuminate = {
            enabled = true,
            lsp = false,
          },
          which_key = true,
        },
      })
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    event = "VeryLazy",
    -- priority = 1000,
    config = function()

    end,
  },
  {
    "briones-gabriel/darcula-solid.nvim",
    event = "VeryLazy",
      -- priority = 1000,
    dependencies = { "rktjmp/lush.nvim" },
  },
  {
    "rose-pine/neovim",
    event = "VeryLazy",
  },
  {
    "mcchrish/zenbones.nvim",
    requires = "rktjmp/lush.nvim",
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      })
    end
  },
}

return M
