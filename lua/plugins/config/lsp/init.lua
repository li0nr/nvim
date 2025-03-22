--[[
Called by "lua/plugins/spec/lsp.lua"
]]
--

local M = {}

local setup_diagnostic_config = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "󰙎" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(
      sign.name,
      { texthl = sign.name, text = sign.text, numhl = "" }
    )
  end
  vim.diagnostic.config({
    underline = true,
    --[[ virtual_text = {
      severity = vim.diagnostic.severity.ERROR,
      source = true,
      spacing = 5,
    }, ]]
    virtual_text = false,
    signs = { active = signs },
    severity_sort = true,
    float = { source = true },
  })

vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "Next diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "Previous diagnostic" })
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Diagnostics under cursor" })
end

local setup_custom_handlers = function()
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

local setup_other_lsps = function(lspconfig)
  local vanilla = require("plugins.config.lsp.vanilla")

  --[[
    For a server which we want to customize significantly, like we are doing for
    `clangd` and `lua`, we would move it out of the list below, and have a file
    adjacent to this with the name of the server. See `clangd.lua` and
    `lua_ls.lua` for examples.
    -- I stopped using Mason, as I have found it unecessary the language server needs to be installed on the system...
    --]]
  for _, server in ipairs({
    "bashls",
    "cmake",
  }) do
    lspconfig[server].setup({
      on_attach = function(client, bufnr)
        vanilla.setup_native_buffer_mappings(client, bufnr)
      end,
      capabilities = vanilla.capabilities,
    })
  end
end

M.setup = function(lspconfig)

  setup_diagnostic_config()
  setup_custom_handlers()

  require("plugins.config.lsp.clangd").setup()
  require("plugins.config.lsp.lua_ls").setup()
  require("plugins.config.lsp.ruff_lsp").setup()
  require("plugins.config.lsp.pyright").setup()
  require("plugins.config.lsp.zls").setup()

  setup_other_lsps(lspconfig)
end

return M
