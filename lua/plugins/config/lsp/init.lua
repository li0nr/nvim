--[[
Called by "lua/plugins/spec/lsp.lua"
]]
--

local M = {}

local setup_diagnostic_config = function()
  vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end,
    { noremap = true, silent = true, desc = "Next diagnostic" })
  vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end,
    { noremap = true, silent = true, desc = "Previous diagnostic" })
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Diagnostics under cursor" })
end

local config = {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "󰙎",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "single",
    source = "always",
    header = "",
    prefix = "",
    suffix = "",
  },
}
vim.diagnostic.config(config)


local setup_other_lsps = function()
  local vanilla = require("plugins.config.lsp.vanilla")
  for _, server in ipairs({
    "bashls",
    "cmake",
    "lua_ls",
    "ty",
    "zls",
    "ruff"
  }) do
    vim.lsp.config(server, {
      on_attach = function(client, bufnr)
        vanilla.setup_native_buffer_mappings(client, bufnr)
      end,
      capabilities = vanilla.capabilities,
    })
  end
end

M.setup = function()

  setup_diagnostic_config()
  require("plugins.config.lsp.clangd").setup()
  require("plugins.config.lsp.pyright").setup()

  setup_other_lsps()
  vim.lsp.enable({ 'clangd' })
  vim.lsp.enable({ 'lua_ls' })
  vim.lsp.enable({ 'pyright', 'ruff', 'ty' })
  vim.lsp.enable({ 'zls' })
  vim.lsp.enable({ 'bashls' })
  -- vim.lsp.enable({ 'cmake' })
end

return M
