local M = {
  {
    -- https://github.com/neovim/nvim-lspconfig
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "saghen/blink.cmp" },
      { "aznhe21/actions-preview.nvim" },
      { "p00f/clangd_extensions.nvim" },
      { "folke/lazydev.nvim" }
    },
    opts = { autoformat = false },
    --[[
    For the core lsp config, its done outside the lazy spec folder as the
    configuration is intenally modular and I would like to fuzzy find my way into
    a specific part of the config in future, eg keymaps, clangd, lua, python, etc..
    --]]
    config = function()
      -- plugins we installed
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")

      -- our config
      local plugins_config_lsp = require("plugins.config.lsp")

      -- pass the imported plugins to our config so that we can setup the
      -- configuration with all of them present, and not have to juggle with
      -- `pcall()`s.
      plugins_config_lsp.setup(mason, mason_lspconfig, lspconfig)
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    -- https://github.com/p00f/clangd_extensions.nvim
    "p00f/clangd_extensions.nvim",
    event = { "BufReadPre", "BufNewFile" },
    -- The `filetypes` come from the default `filetypes` specified for
    -- `clangd` in `lspconfig` documentation
    ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    opts = {
      inlay_hints = {
        only_current_line = true,
        only_current_line_autocmd = { "CursorHold" },
      },
    },
  },
  {
    -- deprecated for outline.nvim
    -- f01eae624e6170656b6fadd6d7b8717636078bd6 commit I have worked with
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { -- Example mapping to toggle outline
      { "<leader>lo", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      outline_items = {
        highlight_hovered_item = false,
      },
      symbol_folding = {
        autofold_depth = false,
      },
    },
  },
}

return M
-- https://github.com/simrat39/symbols-outline.nvim
-- https://github.com/ray-x/lsp_signature.nvim
-- https://github.com/Bekaboo/dropbar.nvim
