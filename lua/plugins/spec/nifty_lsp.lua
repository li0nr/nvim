local M = {
  {
    -- https://github.com/j-hui/fidget.nvim
    "j-hui/fidget.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  --[[ {
  --dont need this for now, maybe add later
    -- https://github.com/ray-x/lsp_signature.nvim
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        -- spec elsewhere
        "folke/which-key.nvim",
      },
    },
    opts = {
      close_timeout = 1500,
      transparency = 15,
      toggle_key = "<M-l>",
      select_signature_key = "<M-e>",
    },
  }, ]]
  {
    -- https://github.com/simrat39/symbols-outline.nvim
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    config = true,
  },
  --[[
  -- Required Neovim version 0.10
  {
    -- https://github.com/Bekaboo/dropbar.nvim
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
  } ]]
}

return M
